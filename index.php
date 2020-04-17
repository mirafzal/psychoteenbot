<?php

include 'Telegram.php';
include 'User.php';
include 'Texts.php';
include 'Steps.php';
include 'CallbackData.php';
include 'Admin.php';

require_once 'questions.php';

$bot_user_token = '1114225171:AAGMKr9CuaWGvqCChDczlG0JJkmyVS0b_7w'; // '1192533019:AAHB-xbDuhTbePKEPqH6Hh3mH_gBEJ7DL6U';

$bot_admin_token = '1117902598:AAGNNAmMfoZsodJd7NUuzgqUMYCwEoU1aLM';

$questionChannelId = "-1001370622157";

$reviewsChannelId = "-1001434405630";

// Instances the class

$telegramUser = new Telegram($bot_user_token);

$telegramAdmin = new Telegram($bot_admin_token);

$text = $telegramUser->Text();

$chatID = $telegramUser->ChatID();

$callback_query = $telegramUser->Callback_Query();

if ($chatID == null) {

    $chatID = 635793263;

}

// Instances the class

$user = new User($chatID);
$user->setLastMessageId($telegramUser->getData()['message']['message_id']);
$currStep = $user->getStep();

//$txt = json_encode($telegramUser->getData(), JSON_PRETTY_PRINT);
//
//$content = array('chat_id' => 635793263, 'text' => $txt);
//$telegramUser->sendMessage($content);

// bot works normally
echo "<br />";
echo 'vse norm';
echo "<br />";

// main logic
if ($callback_query !== null && $callback_query != '') {

    $callback_data = $telegramUser->Callback_Data();

    $chatID = $telegramUser->Callback_ChatID();

    switch ($callback_data) {
        case CallbackData::MALE:
            $user->setGender("Мужчина");
            chooseAge();
            break;
        case CallbackData::FEMALE:
            $user->setGender("Женщина");
            chooseAge();
            break;
        case CallbackData::AGE_1:
            $user->setAge(Texts::BTN_AGE_1);
            chooseAnswerType();
            break;
        case CallbackData::AGE_2:
            $user->setAge(Texts::BTN_AGE_2);
            chooseAnswerType();
            break;
        case CallbackData::AGE_3:
            $user->setAge(Texts::BTN_AGE_3);
            chooseAnswerType();
            break;
        case CallbackData::TEXT:
            $user->setAnswerType('Текст');
            askQuestion();
            break;
        case CallbackData::AUDIO:
            $user->setAnswerType('Аудио');
            askQuestion();
            break;
        case CallbackData::ASK_AGAIN:
            chooseAnswerType();
            break;
        case CallbackData::LIKE:
            //save
            sendThanks(Texts::TXT_AFTER_LIKE);
            break;
        case CallbackData::DISLIKE:
            //save
            sendThanks(Texts::TXT_AFTER_DISLIKE);
            break;
    }

    // answer nothing with answerCallbackQuery, because it is required

    $content = ['callback_query_id' => $telegramUser->Callback_ID(), 'text' => '', 'show_alert' => false];

    $telegramUser->answerCallbackQuery($content);

} elseif ($text == '/start') {
    chooseGender();
} elseif ($text == Texts::BTN_ABOUT) {
    sendAbout();
} elseif ($text == Texts::BTN_LEAVE_REVIEW) {
    leaveComment();
} elseif ($user->getStep() == Steps::COMMENT) {
    commentAccepted();
} elseif ($user->getStep() == Steps::WAITING_ANSWER) {
    askLater();
} else { // steps
    switch ($currStep) {
        case Steps::GENDER:
            break;
        case Steps::AGE:
            break;
        case Steps::QUESTION:
            waitAnswer();
            break;
    }
}

function chooseGender()
{
    global $telegramUser, $user;

    $user->setStep(Steps::GENDER);

    $text = Texts::TXT_START;

    $option = [
        // first row
        [$telegramUser->buildInlineKeyboardButton(Texts::BTN_MALE, "", CallbackData::MALE),
            $telegramUser->buildInlineKeyboardButton(Texts::BTN_FEMALE, "", CallbackData::FEMALE)],
    ];
    $keyboard = $telegramUser->buildInlineKeyBoard($option);
    $content = array('chat_id' => $telegramUser->chatID(), 'reply_markup' => $keyboard, 'text' => $text);

    $telegramUser->sendMessage($content);

}

function chooseAge()
{
    global $telegramUser, $user, $callback_query;

    $user->setStep(Steps::AGE);

    $option = [
        // first row
        [$telegramUser->buildInlineKeyboardButton(Texts::BTN_AGE_1, "", CallbackData::AGE_1),
            $telegramUser->buildInlineKeyboardButton(Texts::BTN_AGE_2, "", CallbackData::AGE_2),
            $telegramUser->buildInlineKeyboardButton(Texts::BTN_AGE_3, "", CallbackData::AGE_3),]
    ];
    $keyboard = $telegramUser->buildInlineKeyBoard($option);
    $content = array('chat_id' => $telegramUser->chatID(), 'message_id' => $callback_query['message']['message_id'], 'text' => Texts::TXT_CHOOSE_AGE, 'reply_markup' => $keyboard);

    $telegramUser->editMessageText($content);
}

function askQuestion()
{
    global $telegramUser, $user, $callback_query;

    $user->setStep(Steps::QUESTION);

    $option = [
        [$telegramUser->buildKeyboardButton(Texts::BTN_LEAVE_REVIEW)],
        [$telegramUser->buildKeyboardButton(Texts::BTN_ABOUT)],
        ];
    $keyb = $telegramUser->buildKeyBoard($option, $onetime = false, $resize = true);
    $content = array('chat_id' => $telegramUser->chatID(), 'reply_markup' => $keyb, 'text' => Texts::TXT_ASK_QUESTION);
    $telegramUser->sendMessage($content);

    $content = array('chat_id' => $telegramUser->chatID(), 'message_id' => $callback_query['message']['message_id']);
    $telegramUser->deleteMessage($content);


}

function sendAbout()
{
    global $telegramUser, $user;

    $content = array('chat_id' => $telegramUser->chatID(), 'text' => Texts::TXT_ABOUT);
    $telegramUser->sendMessage($content);
}

function waitAnswer()
{
    global $telegramUser, $user, $questionChannelId;

    if ($telegramUser->getData()['message']['text'] != null) {
        saveQuestion($telegramUser->ChatID(), $telegramUser->Text());
    } elseif ($telegramUser->getData()['message']['voice'] != null) {
        downloadFile($telegramUser->getData()['message']['voice']['file_id']);
        $voiceFileID = "voiceMessage".$telegramUser->getData()['message']['voice']['file_id'];
        saveQuestion($telegramUser->ChatID(), $voiceFileID);
    } else {
        return;
    }

    $content = array('chat_id' => $telegramUser->chatID(), 'text' => Texts::TXT_WAIT_ANSWER);
    $telegramUser->sendMessage($content);

    $user->setStep(Steps::WAITING_ANSWER);

    notifyAdmin();

    $content = array('chat_id' => $questionChannelId,
        'from_chat_id' => $telegramUser->ChatID(), 'message_id' => $telegramUser->getData()['message']['message_id']);
    $telegramUser->forwardMessage($content);
}

function notifyAdmin()
{
    global $telegramAdmin;

    foreach (Admin::admins as $chatID) {
        $content = array('chat_id' => $chatID, 'text' => "Поступил новый вопрос");
        $telegramAdmin->sendMessage($content);
    }
}

function ggwp($txt)
{
    global $telegramUser, $admin;
    $content = array('chat_id' => $telegramUser->ChatID(), 'text' => $txt);
    $telegramUser->sendMessage($content);
}

function askLater()
{
    global $telegramUser;
    $content = array('chat_id' => $telegramUser->ChatID(), 'text' => Texts::TXT_ASK_LATER);
    $telegramUser->sendMessage($content);
}

function chooseAnswerType() {
    global $telegramUser, $user, $callback_query;

    $user->setStep(Steps::ANSWER_TYPE);

    $option = [
        // first row
        [$telegramUser->buildInlineKeyboardButton(Texts::BTN_TEXT_MESSAGE, "", CallbackData::TEXT)],
        [$telegramUser->buildInlineKeyboardButton(Texts::BTN_AUDIO_MESSAGE, "", CallbackData::AUDIO)],
    ];
    $keyboard = $telegramUser->buildInlineKeyBoard($option);
    $content = array('chat_id' => $telegramUser->chatID(), 'message_id' => $callback_query['message']['message_id'],
        'text' => Texts::TXT_CHOOSE_ANSWER_TYPE, 'reply_markup' => $keyboard);

    $telegramUser->editMessageText($content);
}

function sendThanks($text) {
    global $telegramUser, $user, $callback_query;

    $user->setStep(Steps::QUESTION);

    $option = [
        // first row
        [$telegramUser->buildInlineKeyboardButton(Texts::BTN_ASK_AGAIN, "", CallbackData::ASK_AGAIN)],
    ];
    $keyboard = $telegramUser->buildInlineKeyBoard($option);
    $content = array('chat_id' => $telegramUser->chatID(), 'message_id' => $callback_query['message']['message_id'],
        'text' => $text, 'reply_markup' => $keyboard);

    $telegramUser->editMessageText($content);
}

function downloadFile($file_id) {
    global $bot_user_token, $telegramUser;
    $dir_to_save = "audios/";
    $downloadLink = "https://api.telegram.org/file/bot".$bot_user_token."/".$telegramUser->getFile($file_id)['result']['file_path'];
    if (!is_dir($dir_to_save)) {
        mkdir($dir_to_save);
    }
    file_put_contents($dir_to_save.$file_id.".oga",
        file_get_contents($downloadLink));
}

function leaveComment() {
    global $telegramUser, $user;
    $user->setStep(Steps::COMMENT);
    $content = array('chat_id' => $telegramUser->ChatID(), 'text' => Texts::TXT_PLZ_WRITE_COMMENT);
    $telegramUser->sendMessage($content);
}

function commentAccepted() {
    global $telegramUser, $user, $reviewsChannelId;
    $user->setStep(Steps::QUESTION);
    $option = [
        // first row
        [$telegramUser->buildInlineKeyboardButton(Texts::BTN_ASK_AGAIN, "", CallbackData::ASK_AGAIN)],
    ];
    $keyboard = $telegramUser->buildInlineKeyBoard($option);
    $content = array('chat_id' => $telegramUser->chatID(),
        'text' => Texts::TXT_THANKS_FOR_COMMENT, 'reply_markup' => $keyboard);

    $telegramUser->sendMessage($content);

    $content = array('chat_id' => $reviewsChannelId,
        'from_chat_id' => $telegramUser->ChatID(), 'message_id' => $telegramUser->getData()['message']['message_id']);
    $telegramUser->forwardMessage($content);
}