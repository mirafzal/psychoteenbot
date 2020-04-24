<?php

require_once("db_connect.php");

deleteOldQuestions();

function deleteOldQuestions() {
    global $db;

    $result = $db->query("SELECT * FROM `questions`");

    while ($arr = $result->fetch_assoc()) {
        if (isset($arr['time'])) {
            $hour = (int) ($arr['time'][0].$arr['time'][1]);
            $minute = (int) ($arr['time'][3].$arr['time'][4]);
            $time = $hour * 60 + $minute;

            $currHour = (int) (date("H"));
            $currMinute = (int) (date("i"));

            echo "hour: ".$hour."<br /> ";
            echo "currHourBefore: ".$currHour."<br /> ";

            if ($currHour - $hour < 0) {
                $currHour += 24;
            }

            echo "currHourAfter: ".$currHour."<br /> ";

            $currTime = $currHour * 60 + $currMinute;

            echo "currTime: ".$currTime."<br /> ";
            echo "timediff: ".($currTime - $time)."<br /> ";
            if (($currTime - $time) > 12 * 60) {
                $questionID = $arr['id'];
                echo "YES <br /> ";
                $db->query("DELETE FROM `questions` WHERE `questions`.`id` = '$questionID'");
            }
        }
    }
}
