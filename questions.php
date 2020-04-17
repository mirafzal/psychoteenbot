<?php

require_once("db_connect.php");
require_once("questionDeleter.php");
include 'AdminTableKeys.php';

function saveQuestion($chatID, $question) {
    global $db;

    $question = base64_encode($question);

    $db->query("INSERT INTO `questions` (`chatID`, `question`) VALUES ('$chatID', '$question')") or die("gg((");

}

function saveLastMessageId($chatID, $messageID) {
    global $db;

    $db->query("UPDATE `questions` SET `answer_message_id` = '$messageID' WHERE `chatID` = '$chatID'") or die("ggg((");
}

function getQuestionById($id) {
    global $db;

    $question = "Нет такого вопроса";

    $result = $db->query("SELECT question FROM `questions` WHERE `id` = $id");

    $arr = $result->fetch_assoc();

    if ($arr['question'] != null) {

        $question = base64_decode($arr['question']);

    }

    return $question;
}

function getAllQuestionsIds() {
    global $db;

    deleteOldQuestions();

    $res = [];

    $result = $db->query("SELECT id FROM `questions`");

    while ($arr = $result->fetch_assoc()) {
        if (isset($arr['id'])) {

            $res[] = $arr['id'];

        }
    }

    return $res;
}

function saveAnswer($id, $answer, $answer_chat_id, $answer_message_id) {
    global $db;

    $answer = base64_encode($answer);

    $db->query("UPDATE `questions` SET `answer` = '$answer', `is_answered` = '1', `answer_chat_id` = '$answer_chat_id', 
                       `answer_message_id` = '$answer_message_id' WHERE `questions`.`id` = '$id'") or die("gg((");
}

function setRejected($id) {
    global $db;

    $db->query("UPDATE `questions` SET `is_rejected` = '1' WHERE `questions`.`id` = '$id'") or die("gg((");
}

function getAnswerById($id) {
    $question = getData($id)[AdminTableKeys::QUESTION];

    if ($question == null) {
        $question = "Нет такого ответа";
    }

    return $question;
}

function getUserChatId($id) {

    return getData($id)[AdminTableKeys::CHAT_ID];
}

function getData($id) {
    global $db;

    $result = $db->query("SELECT * FROM `questions` WHERE `id` = $id");

    $arr = $result->fetch_assoc();

    if ($arr[AdminTableKeys::QUESTION] != null) {
        $arr[AdminTableKeys::QUESTION] = base64_decode($arr[AdminTableKeys::QUESTION]);
    } else {
        $arr[AdminTableKeys::QUESTION] = "Нет такого вопроса";
    }

    if ($arr[AdminTableKeys::ANSWER] != null) {
        $arr[AdminTableKeys::ANSWER] = base64_decode($arr[AdminTableKeys::ANSWER]);
    } else {
        $arr[AdminTableKeys::ANSWER] = "Нет такого ответа";
    }

    return $arr;
}