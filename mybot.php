<?php

include 'Telegram.php';
include 'Texts.php';///////////
include 'CallbackData.php';/////////////

$telegram = new Telegram('1192533019:AAHB-xbDuhTbePKEPqH6Hh3mH_gBEJ7DL6U');//'1114225171:AAGMKr9CuaWGvqCChDczlG0JJkmyVS0b_7w');

$result = $telegram->getData();
$text = $result['message'] ['text'];
$chat_id = $result['message'] ['chat']['id'];
$username = $result['message'] ['chat']['username'];
$firstname = $result['message'] ['chat']['first_name'];
$lastname = $result['message'] ['chat']['last_name'];

$admin_chat_ids = [635793263, 583412087, 676244920];

if (!file_exists("counter.txt")) {
	file_put_contents("counter.txt", 1);
}

if ($chat_id == null) {

    $chat_id = 635793263;

}

$callback_query = $telegram->Callback_Query();

$id = substr(file_get_contents($chat_id."step.txt"), 7);
echo $id;

$txt = json_encode($telegram->getData(), JSON_PRETTY_PRINT);

$content = array('chat_id' => $telegram->ChatID(), 'text' => $txt);
$telegram->sendMessage($content);

$voiceFileID = "AwACAgIAAxkBAAICM16XSgcOToNROJKpArwYbpsE8Lc1AAJ5BwACjl-4SONiukfFgQurGAQ";
    $option = [
        [$telegram->buildInlineKeyBoardButton(Texts::BTN_WRITE_ANSWER, "", CallbackData::ACCEPT)],
        [$telegram->buildInlineKeyboardButton(Texts::BTN_NOT_CORRECT_QUESTION, "", CallbackData::REJECT)],
        [$telegram->buildInlineKeyboardButton(Texts::BTN_BACK, "", CallbackData::CANCEL)],
    ];
    $keyb = $telegram->buildInlineKeyBoard($option);
    $content = array('chat_id' => $telegram->ChatID(),
        'voice' => $voiceFileID,
        'caption' => 'gergnvlerhbgvlrtbg', 'reply_markup' => $keyb);
    $telegram->sendVoice($content);


// test file reading
//
// $questionsFile = fopen("questions.txt", "a+") or die("Unable to open file!");
// 		$option = [];
// 		while(!feof($questionsFile)) {
// 			$line = fgets($questionsFile);
// 			if ($line == "") {
// 				break;
// 			}
//   			$word_arr = explode("*^*", $line);
//   			echo $word_arr[0]." ".$word_arr[1]." ".$word_arr[2]."<br>";
//   	// 		$contents = file_get_contents("questions.txt");
// 			// $contents = str_replace($line, '', $contents);
// 			// file_put_contents("questions.txt", $contents);
// 		}

if (in_array($chat_id, $admin_chat_ids)) { //admin panel
	if ($callback_query !== null && $callback_query != '') {

		//answer nothing with answerCallbackQuery, because it is required

    	$content = ['callback_query_id' => $telegram->Callback_ID(), 'text' => '', 'show_alert' => false];

    	$telegram->answerCallbackQuery($content);

    	$callback_data = $telegram->Callback_Data();

    	$chat_id = $telegram->Callback_ChatID();

    	$questionsFile = fopen("questions.txt", "a+") or die("Unable to open file!");

    	$option = [
    		[$telegram->buildKeyboardButton("❌ Отменить")],
    	];
		$keyb = $telegram->buildKeyBoard($option, $onetime=false,  $resize=true);
		while(!feof($questionsFile)) {
			$line = fgets($questionsFile);
			if ($line == "") {
				break;
			}
  			$word_arr = explode("*^*", $line);
  			if ($word_arr[0] == $callback_data) {
  				file_put_contents($chat_id."step.txt", "answer ".$word_arr[0]);
  		    	$content = array('chat_id' => $chat_id, 'reply_markup' => $keyb, 'text' => "Напишите ответ.\nВопрос:\n".$word_arr[2]);
				$telegram->sendMessage($content);
  				break;
  			}
		}
		fclose($questionsFile);

	} elseif ($text == "/start" || $text == "❌ Отменить") {
		$option = [
    		[$telegram->buildKeyboardButton("Ответить на вопросы")],
    	];
		$keyb = $telegram->buildKeyBoard($option, $onetime=false,  $resize=true);
		$content = array('chat_id' => $chat_id, 'reply_markup' => $keyb, 'text' => "Добро пожаловать в панель для администратора. Здесь вы можете отвечать на вопросы подписчиков.");
		$telegram->sendMessage($content);		

		file_put_contents($chat_id."step.txt", "main");
	} elseif (strpos(file_get_contents($chat_id."step.txt"), "answer") !== false) {
		$id = substr(file_get_contents($chat_id."step.txt"), 7);

    	$questionsFile = fopen("questions.txt", "a+") or die("Unable to open file!");

		while(!feof($questionsFile)) {
			$line = fgets($questionsFile);
			if ($line == "") {
				break;
			}
  			$word_arr = explode("*^*", $line);
  			if ($word_arr[0] == $id) {
  				//asnwer is ready
  		    	$content = array('chat_id' => $word_arr[1], 'text' => "✅ Ваш ответ готов!\n\nВопрос:\n".$word_arr[2]."\nОтвет:\n".$text);
				$telegram->sendMessage($content);
				//please rate us!
				$option = [
					[$telegram->buildInlineKeyBoardButton("👍", $url = "", $callback_data = "good"), 
					 $telegram->buildInlineKeyBoardButton("👎", $url = "", $callback_data = "bad")]
				];
				$keyb = $telegram->buildInlineKeyBoard($option);
				$content = array('chat_id' => $word_arr[1], 'reply_markup' => $keyb, 'text' => "Пожалуйста, оцените качество нашей услуги! 😇");
				$telegram->sendMessage($content);

				file_put_contents($word_arr[1]."step.txt", "rating");
				//dev log
				$content = array('chat_id' => 635793263, 'text' => "(Разраб) Ответ готов.\n\nВопрос:\n".$word_arr[2]."\nОтвет:\n".$text);
				$telegram->sendMessage($content);

				$contents = file_get_contents("questions.txt");
				$contents = str_replace($line, '', $contents);
				file_put_contents("questions.txt", $contents);
  				break;
  			}
		}
		fclose($questionsFile);

		$content = array('chat_id' => $chat_id, 'text' => "Ответ отправлен успешно.");
		$telegram->sendMessage($content);

		$option = [
    		[$telegram->buildKeyboardButton("Ответить на вопросы")],
    	];
		$keyb = $telegram->buildKeyBoard($option, $onetime=false,  $resize=true);
		$content = array('chat_id' => $chat_id, 'reply_markup' => $keyb, 'text' => "Главное меню.");
		$telegram->sendMessage($content);		

		file_put_contents($chat_id."step.txt", "main");
	} elseif ($text == "Ответить на вопросы") {
		if (file_get_contents("questions.txt") == "") {
			$content = array('chat_id' => $chat_id, 'text' => "Вопросов на данный момент нет.");
			$telegram->sendMessage($content);
		} else {
			$questionsFile = fopen("questions.txt", "a+") or die("Unable to open file!");
			$option = [];
			while(!feof($questionsFile)) {
				$line = fgets($questionsFile);
				if ($line == "") {
				break;
				}
  				$word_arr = explode("*^*", $line);
  				$option[] = [$telegram->buildInlineKeyBoardButton($word_arr[0], $url = "", $callback_data = $word_arr[0])];
			}
			fclose($questionsFile);
			$keyb = $telegram->buildInlineKeyBoard($option);
			$content = array('chat_id' => $chat_id, 'reply_markup' => $keyb, 'text' => "Выберите вопрос:");
			$telegram->sendMessage($content);

			file_put_contents($chat_id."step.txt", "main");
		}
	} 

} else { //user panel

if ($callback_query !== null && $callback_query != '') {

	    	//answer nothing with answerCallbackQuery, because it is required

    	$content = ['callback_query_id' => $telegram->Callback_ID(), 'text' => '', 'show_alert' => false];

    	$telegram->answerCallbackQuery($content);

    	$callback_data = $telegram->Callback_Data();

    	$chat_id = $telegram->Callback_ChatID();

    	if (file_get_contents($chat_id."step.txt") == "rating") {
    		$content = ['chat_id' => $chat_id, 'text' => "Спасибо за ваш отзыв! 😊"];
    		$telegram->sendMessage($content);

    		if ($callback_data == "good") {
    			for ($i=0; $i < count($admin_chat_ids); $i++) { 
					$content = array('chat_id' => $admin_chat_ids[$i], 'text' => "Отзыв от пользователя:\nИмя: ".$telegram->FirstName()."\nФамилия: ".$telegram->LastName()."\nusername: @".
						$telegram->Username()."\nОценка: 👍");
					$telegram->sendMessage($content);
				}
    		} elseif ($callback_data == "bad") {
    			for ($i=0; $i < count($admin_chat_ids); $i++) { 
					$content = array('chat_id' => $admin_chat_ids[$i], 'text' => "Отзыв от пользователя:\n\n
						Имя: ".$telegram->FirstName()."\n Фамилия: ".$telegram->LastName()."\nusername: ".
						$telegram->Username()."\nОценка: 👎");
					$telegram->sendMessage($content);
				}    			
    		}

    		file_put_contents($chat_id."step.txt" , "main");

    		$content = ['chat_id' => $chat_id, 'text' => "Спасибо за ваш отзыв! 😊"];
    		$telegram->sendMessage($content);
    	}



	} elseif ($text == "/start" || $text == "❌ Отменить") {
	$option = [
    	[$telegram->buildKeyboardButton("❓ Задать вопрос")], 
    	[$telegram->buildKeyboardButton("ℹ️ О боте")],
    ];
	$keyb = $telegram->buildKeyBoard($option, $onetime=false,  $resize=true);
	$content = array('chat_id' => $chat_id, 'reply_markup' => $keyb, 'text' => "📣 Доброго времени суток! Задайте ваш вопрос и получите ответ в течении часа совершенно бесплатно! 💯
⚠️Акция действует до xx числа.");
	$telegram->sendMessage($content);

	file_put_contents($chat_id."step.txt", "main");
} elseif ($text == "❓ Задать вопрос") {
	$option = [
    	[$telegram->buildKeyboardButton("❌ Отменить")],
    ];
	$keyb = $telegram->buildKeyBoard($option, $onetime=false,  $resize=true);
	$content = array('chat_id' => $chat_id, 'reply_markup' => $keyb, 'text' => "Пожалуйста, напишите свой вопрос.");
	$telegram->sendMessage($content);

	file_put_contents($chat_id."step.txt", "question");
} elseif ($text == "ℹ️ О боте") {
	$content = array('chat_id' => $chat_id, 'text' => "❗️КОНФИДЕНЦИАЛЬНО И БЕСПЛАТНО❗️
📢 Индивидуальная онлайн консультация квалифицированного психолога-терапевта для подростоков в возрасте 13-19 лет в сфере отношений. 💕

PsychoTeen также предлагает специальные услуги для родителей и опекунов, которые хотят, чтобы их ребенок получил заслуженную помощь.

Цель PsychoTeen - помочь подросткам справиться с различными проблемами, такими как беспокойство, стресс, чувство собственного достоинства, депрессия, издевательства, расстройства пищевого поведения, отношения или гнев.");
	$telegram->sendMessage($content);
} elseif (file_exists($chat_id."step.txt") && (file_get_contents($chat_id."step.txt") == "question")) {
	$option = [
    	[$telegram->buildKeyboardButton("❓ Задать вопрос")], 
    	[$telegram->buildKeyboardButton("ℹ️ О боте")],
    ];
	$keyb = $telegram->buildKeyBoard($option, $onetime=false,  $resize=true);
	$content = array('chat_id' => $chat_id, 'reply_markup' => $keyb, 'text' => "♻️Ваш вопрос принят. Первый освободившийся психолог ознакомится с Вашей проблемой и вы получите ответ в ближайшее время.");
	$telegram->sendMessage($content);

	$questionsFile = fopen("questions.txt", "a+") or die("Unable to open file!");

	$counter = file_get_contents("counter.txt");

	fwrite($questionsFile, $counter."*^*".$chat_id."*^*".$text."\n");

	$content = array('chat_id' => 635793263, 'text' => "(Разраб) ".$counter."*^*".$chat_id."*^*".$text."\n");
	$telegram->sendMessage($content);	

	file_put_contents("counter.txt", $counter + 1);

	fclose($questionsFile);

	for ($i=0; $i < count($admin_chat_ids); $i++) { 
		$content = array('chat_id' => $admin_chat_ids[$i], 'text' => "Поступил новый вопрос");
		$telegram->sendMessage($content);
	}

	file_put_contents($chat_id."step.txt", "main");
}

}