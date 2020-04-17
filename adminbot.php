<?php

include 'Telegram.php';
include 'Admin.php';
include 'Texts.php';
include 'User.php';
include 'Steps.php';
include 'CallbackData.php';

require_once 'questions.php';

$bot_admin_token = '1117902598:AAGNNAmMfoZsodJd7NUuzgqUMYCwEoU1aLM';

$bot_user_token = '1114225171:AAGMKr9CuaWGvqCChDczlG0JJkmyVS0b_7w'; //'1192533019:AAHB-xbDuhTbePKEPqH6Hh3mH_gBEJ7DL6U';

// Instances the class

$telegramAdmin = new Telegram($bot_admin_token);

$telegramUser = new Telegram($bot_user_token);

$text = $telegramAdmin->Text();

$chatID = $telegramAdmin->ChatID();

$callback_query = $telegramAdmin->Callback_Query();

$messageID = $telegramAdmin->getData()['message']['message_id'];

if ($chatID == null) {

    $chatID = 635793263;

}

//$txt = json_encode($telegramAdmin->getData(), JSON_PRETTY_PRINT);
//
//$content = array('chat_id' => $telegramAdmin->ChatID(), 'text' => $txt);
//$telegramAdmin->sendMessage($content);

$admin = new Admin($chatID);

echo $admin->getStep();

if (in_array($chatID, Admin::admins)) {
    if ($callback_query !== null && $callback_query != '') {

        $callback_data = $telegramAdmin->Callback_Data();
        $chatID = $telegramAdmin->Callback_ChatID();

        switch ($admin->getStep()) {
            case Steps::ADMIN_QUESTIONS:
                if (strpos($callback_data, "gg") !== false) {
                    showChosenQuestion(substr($callback_data, 2), $callback_query['message']['message_id']);
                }
                break;
            case Steps::ADMIN_VIEWING_QUESTION:
                switch ($callback_data) {
                    case CallbackData::ACCEPT:
                        beginAnswer($callback_query['message']['message_id']);
                        break;
                    case CallbackData::REJECT:
                        rejectQuestion($callback_query['message']['message_id']);
                        break;
                    case CallbackData::CANCEL:
                        showQuestionsList($callback_query['message']['message_id'], true);
                        break;
                }
                break;
        }

        // answer nothing with answerCallbackQuery, because it is required
        $content = ['callback_query_id' => $telegramAdmin->Callback_ID(), 'text' => '', 'show_alert' => false];
        $telegramAdmin->answerCallbackQuery($content);

    } elseif ($text == "/start") {
        sendWelcomeMessage();
    } elseif ($text == Texts::BTN_ANSWER) {
        showQuestionsList();
    } elseif ($text == Texts::BTN_CANCEL) {
        sendMainMenu();
    } elseif ($admin->getStep() == Steps::ADMIN_ANSWERING) {
        answerToUser();
    }
}

function sendWelcomeMessage()
{
    global $telegramAdmin, $admin;

    $admin->setStep(Steps::QUESTION);

    $option = [
        [$telegramAdmin->buildKeyboardButton(Texts::BTN_ANSWER)],
    ];
    $keyb = $telegramAdmin->buildKeyBoard($option, $onetime = false, $resize = true);
    $content = array('chat_id' => $telegramAdmin->ChatID(), 'reply_markup' => $keyb, 'text' => Texts::TXT_WELCOME);
    $telegramAdmin->sendMessage($content);
}

function sendMainMenu() {
    global $telegramAdmin, $admin;

    $admin->setStep(Steps::QUESTION);

    $option = [
        [$telegramAdmin->buildKeyboardButton(Texts::BTN_ANSWER)],
    ];
    $keyb = $telegramAdmin->buildKeyBoard($option, $onetime = false, $resize = true);
    $content = array('chat_id' => $telegramAdmin->ChatID(), 'reply_markup' => $keyb, 'text' => Texts::TXT_MAIN_PAGE);
    $telegramAdmin->sendMessage($content);
}

function showQuestionsList($messageID = 1, $edit = false)
{
    global $telegramAdmin, $admin;
    $admin->setStep(Steps::ADMIN_QUESTIONS);
    if (empty(getAllQuestionsIds())) {
        $content = array('chat_id' => $telegramAdmin->ChatID(), 'text' => Texts::TXT_NO_QUESTION);
        $telegramAdmin->sendMessage($content);
    } else {
        $option = [];
        foreach (getAllQuestionsIds() as $id) {
            if (getData($id)[AdminTableKeys::IS_ANSWERED]) {
                $option[] = [$telegramAdmin->buildInlineKeyBoardButton($id . " (Ответ дан)", $url = "", $callback_data = "gg" . $id)];
            } elseif (getData($id)[AdminTableKeys::IS_REJECTED]) {
                $option[] = [$telegramAdmin->buildInlineKeyBoardButton($id . " (Некорректный)", $url = "", $callback_data = "gg" . $id)];
            } else {
                $option[] = [$telegramAdmin->buildInlineKeyBoardButton($id . "", $url = "", $callback_data = "gg" . $id)];
            }

        }
        $keyb = $telegramAdmin->buildInlineKeyBoard($option);
        if (!$edit) {
            $content = array('chat_id' => $telegramAdmin->ChatID(), 'reply_markup' => $keyb, 'text' => Texts::TXT_CHOOSE_QUESTION);
            $telegramAdmin->sendMessage($content);
        } else {
            $content = array('chat_id' => $telegramAdmin->ChatID(), 'message_id' => $messageID, 'reply_markup' => $keyb, 'text' => Texts::TXT_CHOOSE_QUESTION);
            $telegramAdmin->editMessageText($content);
        }

    }

    $admin->setAnsweringQuestionId(0);
}

function ggwp($txt)
{
    global $telegramAdmin, $admin;
    $content = array('chat_id' => $telegramAdmin->ChatID(), 'text' => $txt . " | currstep: " . $admin->getStep());
    $telegramAdmin->sendMessage($content);
}

function showChosenQuestion($id, $messageID)
{
    global $telegramAdmin, $admin;

    $admin->setStep(Steps::ADMIN_VIEWING_QUESTION);

    $admin->setAnsweringQuestionId($id);

    $question = getData($id)[AdminTableKeys::QUESTION];

    $user = new User(getData($id)[AdminTableKeys::CHAT_ID]);

    $gender = $user->getGender();
    $age = $user->getAge();

    $option = [
        [$telegramAdmin->buildInlineKeyBoardButton(Texts::BTN_WRITE_ANSWER, "", CallbackData::ACCEPT)],
        [$telegramAdmin->buildInlineKeyboardButton(Texts::BTN_NOT_CORRECT_QUESTION, "", CallbackData::REJECT)],
        [$telegramAdmin->buildInlineKeyboardButton(Texts::BTN_BACK, "", CallbackData::CANCEL)],
    ];
    $keyb = $telegramAdmin->buildInlineKeyBoard($option);

    if (strpos($question, "voiceMessage") !== false) {
        $voiceFileID = substr($question, 12);
        sendVoice($voiceFileID, $telegramAdmin->ChatID(), true,
            "Пол: ".$gender."\nВозраст: ".$age."\nПредпочитаемый тип ответа: ".$user->getAnswerType(), $keyb);
    } else {
        $content = array('chat_id' => $telegramAdmin->ChatID(), 'message_id' => $messageID, 'reply_markup' => $keyb,
            'text' => "Пол: ".$gender."\nВозраст: ".$age."\nПредпочитаемый тип ответа: ".$user->getAnswerType()."\n". Texts::TXT_QUESTION . $question);
        $telegramAdmin->editMessageText($content);
    }


}

function answerToUser()
{
    global $telegramAdmin, $telegramUser, $admin;

    $admin->setStep(Steps::ADMIN_QUESTIONS);

    $questionId = $admin->getAnsweringQuestionId();

    $question = getData($questionId)[AdminTableKeys::QUESTION];

    $userChatID = getData($questionId)[AdminTableKeys::CHAT_ID];

    $user = new User($userChatID);

    $isText = true;

    if ($telegramAdmin->getData()['message']['text'] != null) {
        saveAnswer($questionId, $telegramAdmin->Text(), $telegramAdmin->ChatID(), $user->getLastMessageID());
    } elseif ($telegramAdmin->getData()['message']['voice'] != null) {
        $isText = false;
        downloadFile($telegramAdmin->getData()['message']['voice']['file_id']);
        $voiceFileIDAnswer = "voiceMessage".$telegramAdmin->getData()['message']['voice']['file_id'];
        saveAnswer($questionId, $voiceFileIDAnswer, $telegramAdmin->ChatID(), $user->getLastMessageId());
    }
    if ($isText) {
        if (strpos($question, "voiceMessage") !== false) {
            $voiceFileID = substr($question, 12);
            $content = array('chat_id' => $userChatID,
                'text' => Texts::TXT_ANSWER_READY_1);
            $telegramUser->sendMessage($content);
            sendVoice($voiceFileID, $userChatID, false);
            $content = array('chat_id' => $userChatID,
                'text' => Texts::TXT_ANSWER_READY_2.$telegramAdmin->Text());
            $telegramUser->sendMessage($content);
        } else {
            $content = array('chat_id' => $userChatID,
                'text' => Texts::TXT_ANSWER_READY_1.$question.Texts::TXT_ANSWER_READY_2.$telegramAdmin->Text());
            $telegramUser->sendMessage($content);
        }
    } else {
        $voiceFileIDAnswer = substr($voiceFileIDAnswer, 12);
        if (strpos($question, "voiceMessage") !== false) {
            $voiceFileID = substr($question, 12);
            $content = array('chat_id' => $userChatID,
                'text' => Texts::TXT_ANSWER_READY_1);
            $telegramUser->sendMessage($content);
            sendVoice($voiceFileID, $userChatID, false);
            $content = array('chat_id' => $userChatID,
                'text' => Texts::TXT_ANSWER_READY_2);
            $telegramUser->sendMessage($content);
            sendVoice($voiceFileIDAnswer, $userChatID, false);
        } else {
            $content = array('chat_id' => $userChatID,
                'text' => Texts::TXT_ANSWER_READY_1.$question.Texts::TXT_ANSWER_READY_2);
            $telegramUser->sendMessage($content);
            sendVoice($voiceFileIDAnswer, $userChatID, false);
        }
    }

    $option = [
        // first row
        [$telegramUser->buildInlineKeyboardButton(Texts::BTN_LIKE, "", CallbackData::LIKE),
            $telegramUser->buildInlineKeyboardButton(Texts::BTN_DISLIKE, "", CallbackData::DISLIKE)],
    ];
    $keyboard = $telegramUser->buildInlineKeyBoard($option);
    $content = array('chat_id' => getData($questionId)[AdminTableKeys::CHAT_ID], 'reply_markup' => $keyboard, 'text' => Texts::TXT_RATE_ANSWER);

    $telegramUser->sendMessage($content);

    $user->setStep(Steps::QUESTION);

//    $content = array('chat_id' => $telegramUser->chatID(), 'text' => Texts::TXT_YOU_CAN_ASK_AGAIN);
//    $telegramUser->sendMessage($content);

    $option = [
        [$telegramAdmin->buildKeyboardButton(Texts::BTN_ANSWER)],
    ];
    $keyb = $telegramAdmin->buildKeyBoard($option, $onetime = false, $resize = true);
    $content = array('chat_id' => $telegramAdmin->ChatID(), 'reply_markup' => $keyb, 'text' => Texts::TXT_QUESTION_ANSWERED);
    $telegramAdmin->sendMessage($content);

}

function beginAnswer($messageID)
{
    global $telegramAdmin, $admin;

    $questionId = $admin->getAnsweringQuestionId();

    $question = getData($questionId)[AdminTableKeys::QUESTION];

    $user = new User(getData($questionId)[AdminTableKeys::CHAT_ID]);

    $gender = $user->getGender();
    $age = $user->getAge();

    $content = array('chat_id' => $telegramAdmin->ChatID(), 'message_id' => $messageID,
        'text' => "Пол: ".$gender."\nВозраст: ".$age."\nПредпочитаемый тип ответа: ".$user->getAnswerType()."\n". Texts::TXT_QUESTION . $question);
    $telegramAdmin->editMessageText($content);

    $option = [
        [$telegramAdmin->buildKeyboardButton(Texts::BTN_CANCEL)],
    ];
    $keyb = $telegramAdmin->buildKeyBoard($option, $onetime = false, $resize = true);
    $content = array('chat_id' => $telegramAdmin->ChatID(), 'reply_markup' => $keyb, 'text' => Texts::TXT_WRITE_ANSWER);
    $telegramAdmin->sendMessage($content);

    $admin->setStep(Steps::ADMIN_ANSWERING);
}

function rejectQuestion($messageID)
{
    global $telegramAdmin, $telegramUser, $admin;

    $questionID = $admin->getAnsweringQuestionId();

    $question = getData($questionID)[AdminTableKeys::QUESTION];

    $content = array('chat_id' => $telegramAdmin->ChatID(), 'message_id' => $messageID, 'text' => Texts::TXT_QUESTION_REJECTED);
    $telegramAdmin->editMessageText($content);

    $content = array('chat_id' => getData($questionID)[AdminTableKeys::CHAT_ID],
        'text' => Texts::TXT_QUESTION_REJECTED_USER);
    $telegramUser->sendMessage($content);

    $user = new User(getData($questionID)[AdminTableKeys::CHAT_ID]);
    $user->setStep(Steps::QUESTION);

    setRejected($questionID);

    $admin->setAnsweringQuestionId(0);
}

function sendVoice($file_id, $chatID, $toAdmin, $caption = "", $keyb = "") {
    global $bot_admin_token, $bot_user_token;

    $botToken = $toAdmin ? $bot_admin_token : $bot_user_token;
    $file = ''.$_SERVER['DOCUMENT_ROOT']."/audios/".$file_id.".oga";
    $mime = mime_content_type($file);
    $info = pathinfo($file);
    $name = $info['basename'];
    $output = new CURLFile($file, $mime, $name);

    $data = array(
        "voice" => $output,
        "chat_id" => $chatID,
    );
    if ($caption != "") {
        $data["caption"] = $caption;
    }
    if ($keyb != "") {
        $data["reply_markup"] = $keyb;
    }
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, "https://api.telegram.org/bot".$botToken."/sendVoice");
    curl_setopt($ch, CURLOPT_POST,1);
    curl_setopt($ch, CURLOPT_POSTFIELDS, $data);
    $result = curl_exec($ch);
    if (curl_errno($ch)) {
        $result = curl_error($ch);
    } else {
        echo 'uraa';
    }
    curl_close ($ch);
}
function downloadFile($file_id) {
    global $bot_admin_token, $telegramAdmin;
    $dir_to_save = "audios/";
    $downloadLink = "https://api.telegram.org/file/bot".$bot_admin_token."/".$telegramAdmin->getFile($file_id)['result']['file_path'];
    if (!is_dir($dir_to_save)) {
        mkdir($dir_to_save);
    }
    file_put_contents($dir_to_save.$file_id.".oga",
        file_get_contents($downloadLink));
}