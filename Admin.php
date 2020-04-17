<?php

require_once("db_connect.php");

class Admin
{
    const admins = [
        635793263, // Мирафзал
        583412087, // Акмаль
        676244920, // Камилла
        659785305 // Михаил
    ];

    private $chatID;

    function __construct($chatID)
    {

        $this->chatID = $chatID;


        if (!$this->isUserSet()) $this->makeUser();

        if ($this->getKeyValue('step') == "") $this->setStep('main_page');

        if ($this->getKeyValue('page') == "") $this->setPage(0);

    }

    /**
     * @param $page int
     */

    function setPage($page)
    {

        $this->setKeyValue('page', $page);

    }

    /**
     * @return int
     */

    function getPage()
    {

        return $this->getKeyValue('page');

    }

    /**
     * @param $step string
     */

    function setStep($step)
    {

        $this->setKeyValue('step', $step);

    }

    /**
     * @return string
     */

    function getStep()
    {

        return $this->getKeyValue('step');

    }

    function setAnsweringQuestionId($id) {
        $this->setKeyValue("answering_question_id", $id);
    }

    function getAnsweringQuestionId() {
        return $this->getKeyValue("answering_question_id");
    }

    private function makeUser()
    {

        global $db;

        $chatID = $db->real_escape_string($this->chatID);


        $query = "insert into `admins`(chatID) values('{$chatID}')";

        if (!$db->query($query))

            die("пользователя создать не удалось");

    }

    private function isUserSet()
    {

        global $db;

        $chatID = $db->real_escape_string($this->chatID);

        $result = $db->query("select * from `admins` where chatID='$chatID'");

        $myArray = (array)($result->fetch_array());

        if (!empty($myArray)) return true;

        return false;

    }


    private function getData()
    {

        global $db;

        $res = array();

        $chatID = $db->real_escape_string($this->chatID);

        $result = $db->query("select * from `admins` where chatID='$chatID'");

        $arr = $result->fetch_assoc();

        if (isset($arr['data_json'])) {

            $res = json_decode($arr['data_json'], true);

        }


        return $res;

    }


    private function setKeyValue($key, $value)
    {

        global $db;

        $chatID = $db->real_escape_string($this->chatID);

        if (!$this->isUserSet()) {

            $this->makeUser(); // если каким-то чудом этот пользователь не зарегистрирован в базе

        }

        $data = $this->getData();

        $data[$key] = $value;

        $data = json_encode($data, JSON_UNESCAPED_UNICODE);

        $db->query("update `admins` SET data_json = '{$data}' WHERE chatID = '{$chatID}'"); // обновляем запись в базе

    }


    private function getKeyValue($key)
    {

        $data = $this->getData();

        if (array_key_exists($key, $data)) {

            return $data[$key];

        }

        return "";


    }

}