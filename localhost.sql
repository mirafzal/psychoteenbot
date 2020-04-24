-- phpMyAdmin SQL Dump
-- version 4.9.5
-- https://www.phpmyadmin.net/
--
-- Хост: localhost:3306
-- Время создания: Апр 24 2020 г., 10:57
-- Версия сервера: 10.3.16-MariaDB
-- Версия PHP: 7.3.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT = @@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS = @@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION = @@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `id13418599_psychoteenbotttdb`
--
CREATE DATABASE IF NOT EXISTS `id13418599_psychoteenbotttdb` DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
USE `id13418599_psychoteenbotttdb`;

-- --------------------------------------------------------

--
-- Структура таблицы `admins`
--

CREATE TABLE `admins`
(
    `id`        int(11) NOT NULL,
    `data_json` longtext COLLATE utf8_unicode_ci DEFAULT NULL,
    `chatID`    int(20) NOT NULL
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE = utf8_unicode_ci;

--
-- Дамп данных таблицы `admins`
--

INSERT INTO `admins` (`id`, `data_json`, `chatID`)
VALUES (4, '{\"step\":3,\"page\":0,\"answering_question_id\":0}', 635793263),
       (5, '{\"step\":3,\"page\":0,\"answering_question_id\":0}', 583412087),
       (6, '{\"step\":3,\"page\":0,\"answering_question_id\":0}', 659785305),
       (7, '{\"step\":2,\"page\":0,\"answering_question_id\":0}', 676244920),
       (8, '{\"step\":3,\"page\":0,\"answering_question_id\":\"109\"}', 482944903);

-- --------------------------------------------------------

--
-- Структура таблицы `questions`
--

CREATE TABLE `questions`
(
    `id`                int(11)    NOT NULL,
    `chatID`            int(20)    NOT NULL,
    `question`          longtext COLLATE utf8_unicode_ci DEFAULT NULL,
    `answer`            longtext COLLATE utf8_unicode_ci DEFAULT NULL,
    `is_answered`       tinyint(1) NOT NULL              DEFAULT 0,
    `is_rejected`       tinyint(1) NOT NULL              DEFAULT 0,
    `answer_chat_id`    int(20)    NOT NULL              DEFAULT 0,
    `answer_message_id` int(20)    NOT NULL              DEFAULT 0,
    `time`              time       NOT NULL              DEFAULT current_timestamp()
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE = utf8_unicode_ci;

--
-- Дамп данных таблицы `questions`
--

INSERT INTO `questions` (`id`, `chatID`, `question`, `answer`, `is_answered`, `is_rejected`, `answer_chat_id`,
                         `answer_message_id`, `time`)
VALUES (241, 1004151361, '0KfRgtC+INGC0LDQutC+0LUg0LLQvtC+0LHRidC1INC70Y7QsdC+0LLRjA==',
        '4pyFLSDQm9GO0LHQvtCy0Ywg4oCSINGN0YLQviDRh9GD0LLRgdGC0LLQviDRh9C10LvQvtCy0LXQutCwLCDQutC+0YLQvtGA0L7QtSDQt9Cw0LrQu9GO0YfQsNC10YLRgdGPINCyINC/0YDQuNCy0Y/Qt9Cw0L3QvdC+0YHRgtC4INC6INC+0LHRitC10LrRgtGDINC70Y7QsdCy0LgsINC20LXQu9Cw0L3QuNC4INC/0L7RgdGC0L7Rj9C90L3QviDQvdCw0YXQvtC00LjRgtGM0YHRjyDRgSDQvdC40Lwg0YDRj9C00L7QvCwg0LTQvtCy0LXRgNGP0YLRjCDQtdC80YMg0LLRgdC1INGB0LLQvtC4INGC0LDQudC90YssINC/0YDQuNC90LjQvNCw0YLRjCDRg9GH0LDRgdGC0LjQtSDQsiDQtdCz0L4g0LbQuNC30L3QuCwg0LfQsNCx0L7RgtC40YLRjNGB0Y8g0L4g0L3QtdC8LgrinIUgLSDQm9GO0LHQuNGC0Ywg4oCSINC30L3QsNGH0LjRgiDQtNCw0YDQuNGC0Ywg0LvRjtCx0L7QstGMLCDQvtCx0LXRgNC10LPQsNGC0Ywg0YfQtdC70L7QstC10LrQsCwg0L/RgNC40L3QvtGB0LjRgtGMINC10LzRgyDRgdGH0LDRgdGC0YzQtSDQuCDQv9C10YDQtdC20LjQstCw0YLRjCDQstC80LXRgdGC0LUg0YEg0L3QuNC8INCy0YHQtSDQv9C10YfQsNC70YzQvdGL0LUg0Lgg0YDQsNC00L7RgdGC0L3Ri9C1INC80L7QvNC10L3RgtGLINC20LjQt9C90LguINCa0L7Qs9C00LAg0YLRiyDQu9GO0LHQuNGI0YwgLCDRgtGLINC80L7QttC10YjRjCDQstGB0LUgLCDRgtGLINC+0YnRg9GJ0LDQtdGI0Ywg0YHQtdCx0Y8g0YHQsNC80YvQvCDQu9GD0YfRiNC40LwgLCAg0YHQuNC70YzQvdGL0LwgLCDQsCDQutC+0LPQtNCwINGN0YLQviDQstC30LDQuNC80L3QviAsINGC0L4g0Y3RgtC+INGH0YLQvi3RgtC+INC90LXQstC10YDQvtGP0YLQvdC+0LUgLgoK0JfQsNC/0L7QvNC90LjRgtC1ICwg0L3QtdGC0YMg0YLQvtGH0L3QvtCz0L4g0L/QvtC90Y/RgtC40Y8gLCDRh9GC0L4g0YLQsNC60L7QtSDQu9GO0LHQvtCy0YwgLCDQutCw0LbQtNGL0Lkg0YfQtdC70L7QstC10Log0L7RidGD0YnQsNC10YIg0Y3RgtC+INC/0L4g0YHQstC+0LXQvNGDIC4KCuKdl++4j9CYINC/0L7QvNC90LjRgtC1OiDQm9GO0LHQvtCy0Ywg0LzQvtC20LXRgiDQuNC30LzQtdC90LjRgtGMINGH0LXQu9C+0LLQtdC60LAg0LTQviDQvdC10YPQt9C90LDQstCw0LXQvNC+0YHRgtC4Lg==',
        1, 0, 676244920, 4478, '00:19:17'),
       (242, 174663798, '0KfRgtC+INC00LXQu9Cw0YLRjCDQutC+0LPQtNCwINGC0LXQsdGPINC90LUg0L/QvtC90LjQvNCw0Y7Rgg==',
        '0J3QtSDQv9C+0L3QuNC80LDRjtGCINCyINGH0LXQvD8g0JrRgtC+INC40LzQtdC90L3Qvj8gCgrinIUg0JTQu9GPINC90LDRh9Cw0LvQsCDQktCw0Lwg0L7QsdGP0LfQsNGC0LXQu9GM0L3QviDQvdGD0LbQvdC+INGB0LXRgdGC0Ywg0Lgg0L7Qv9C40YHQsNGC0Ywg0LLRgdGOINGB0LjRgtGD0LDRhtC40Y4g0LHRg9C60LLQsNC70YzQvdC+INC90LAg0LvQuNGB0YLQvtGH0LrQtSwg0L/QvtC90Y/RgtGMINCy0YHQtSDQvdC10LTQvtGH0ZHRgtGLLCDQstC+0LfQvNC+0LbQvdC+INC/0YDQuNGH0LjQvdGLINC90LXQtNC+0L/QvtC90LjQvNCw0Y8sINCy0YHQtdCz0LTQsCDQtdGB0YLRjCDQstGL0YXQvtC0LCDQuNC3INC70Y7QsdC+0Lkg0YHQuNGC0YPQsNGG0LjQuC4g0JPQu9Cw0LLQvdC+0LUg0YLQvtC70YzQutC+INC30LDRhdC+0YLQtdGC0YwuIAoK4pyF0KHQutC+0YDQtdC1INCy0YHQtdCz0L4sINCy0LDQvCDQtNC10LnRgdGC0LLQuNGC0LXQu9GM0L3QviDRhdC+0YfQtdGC0YHRjywg0YfRgtC+0LHRiyDQu9GO0LTQuCDQsdGL0LvQuCDQuiDQstCw0Lwg0YLQtdGA0L/QuNC80LXQtSDQuCDQstC90LjQvNCw0YLQtdC70YzQvdGLLCDQsCDQutC+0LPQtNCwLdGC0L4g0LTQtdC70LDQu9C4INGC0L4sINGH0YLQviDRhdC+0YfQtdGC0YHRjyDQstCw0LwuINCS0LDQvCDRhdC+0YfQtdGC0YHRjywg0YfRgtC+0LHRiyDQstCw0YEg0L/QvtC90Y/Qu9C4LCDQv9C+0LTQtNC10YDQttCw0LvQuC4g0K3RgtC+INC20LXQu9Cw0L3QuNC1INC10YHRgtC10YHRgtCy0LXQvdC90L7QtSDQuCDQv9C+0L3Rj9GC0L3QvtC1INC4INGF0L7RgNC+0YjQtdC1LiDQotC+0LvRjNC60L4g0L/QvtC00YPQvNCw0LnRgtC1INC+0LEg0L7QtNC90L7QuSDQstC10YnQuDog0KfRgtC+INCy0Ysg0YHQtNC10LvQsNC70LgsINGH0YLQvtCx0Ysg0LvRjtC00Lgg0LfQsNGF0L7RgtC10LvQuCDQstCw0YEg0L/QvtC90LjQvNCw0YLRjD8gCgrinIUg0J/QvtGA0L7QuSDQsdGL0LLQsNGO0YIg0LvRjtC00Lgg0L3QtSDQv9C+0L3QuNC80LDRjtGCINGH0YLQviDQvtGCINC90LjRhSDRhdC+0YLRj9GCLiDQldGB0LvQuCDQstGLINGF0L7RgtC40YLQtSwg0YfRgtC+0LHRiyDQstCw0YEg0L/QvtC90Y/Qu9C4LOKAlCDQv9C+0LnQtNC40YLQtSDQuCDRgdC60LDQttC40YLQtSwg0YfRgtC+INCy0LDQvCDQvdCw0LTQvi4g0JAg0YfRgtC+0LHRiyDQu9GO0LTQuCDRjdGC0L4g0YHQtNC10LvQsNC70Lgg4oCUINC+0LHQtdGB0L/QtdGH0YzRgtC1LCDRh9GC0L7QsdGLINC40Lwg0L4g0LLQsNGBINCx0YvQu9C+INC40L3RgtC10YDQtdGB0L3QviDQt9Cw0LHQvtGC0LjRgtGM0YHRjy7CoAoK4pyFINCj0YfQuNGC0LXRgdGMINGB0LDQvNC4wqDQv9C+0L3QuNC80LDRgtGMINC+0LrRgNGD0LbQsNGO0YnQuNGFLCDRg9GH0LjRgtC10YHRjMKg0YHRgtCw0L3QvtCy0LjRgtGM0YHRjyDQtNC70Y8g0L3QuNGFINC40L3RgtC10YDQtdGB0L3Ri9C80LguINCc0L7QttC10YLQtSDQvdCw0YfQsNGC0Ywg0YEg0YLQvtCz0L4sINGH0YLQvtCx0Ysg0YEg0LrQtdC8LdGC0L4g0L/QvtC80LjRgNC40YLRjNGB0Y8sINC60L7QvNGDLdGC0L4g0L/RgNC+0YHRgtC+INGC0LDQuiDRgdC60LDQt9Cw0YLRjCDQvdC10YHQutC+0LvRjNC60L4g0LTQvtCx0YDRi9GFINGB0LvQvtCyLiDQkdGD0LTRjNGC0LUg0L/RgNC40LzQtdGA0L7QvCDQtNC70Y8g0L7QutGA0YPQttCw0Y7RidC40YUg4pid77iP8J+PvCDQo9Cy0LjQtNC40LIg0JLQsNGIINC90LDRgdGC0YDQvtC5LCDQvtC90Lgg0LfQsNGF0L7RgtGP0YIg0LfQsNGA0Y/QtNC40YLRgdGPINC40Lwg0YLQvtC20LUuIAoK4p2X77iPINCYINC/0L7QvNC90LjRgtC1OgrQn9C+0L3Rj9GC0Ywg0LTRgNGD0LPQvtCz0L4g0YfQtdC70L7QstC10LrQsCDigJQg0LLRgdC1wqDRgNCw0LLQvdC+INGH0YLQvsKg0L7QsdC90Y/RgtGMINC60LDQutGC0YPRgS4g0JLRgdC10Lwg0L3QsNC8wqDQv9GA0LjRhdC+0LTQuNGC0YHRjyDQvtCx0L3QuNC80LDRgtGMINC60LDQutGC0YPRgdGLLiDQktCw0LbQvdC+INC/0L7QstC10YDQuNGC0Ywg0LLCoNGC0L4sINGH0YLQvsKg0Y3RgtC+INC90LXQvtCx0YXQvtC00LjQvNC+LCDQvdCw0YPRh9C40YLRjNGB0Y8g0L3QsNGF0L7QtNC40YLRjCDQssKg0Y3RgtC+0LzCoNGD0LTQvtCy0L7Qu9GM0YHRgtCy0LjQtSwg0LjCoNC+0LTQvdCw0LbQtNGLLCDQutC+0LPQtNCwINGC0LXQsdC1INCx0YPQtNC10YIg0L7Rh9C10L3RjCDQvdGD0LbQvdC+LCDQutGC0L4t0YLQviDQvtCx0L3QuNC80LXRgiDRgtC10LHRj/CfmY8=',
        1, 0, 676244920, 4485, '04:02:04'),
       (243, 753980760,
        '0K8g0LHQvtGO0YHRjCzRh9GC0L4g0YMg0LzQtdC90Y8g0LIg0LbQuNC30L3QuCDQvdC40YfQtdCz0L4g0L3QtSDQv9C+0LvRg9GH0LjRgtGB0Y8uINCvINC90LUg0YHQvNC+0LPRgyDQtNC+0LHQuNGC0YzRgdGPINCy0YvRgdC+0YIg0Lgg0YbQtdC70LXQuQ==',
        '0JHRi9C70Lgg0LvQuCDQsiDQstCw0YjQtdC5INC20LjQt9C90Lgg0YHQuNGC0YPQsNGG0LjQuCwg0LrQvtCz0LTQsCDQsdGD0LrQstCw0LvRjNC90L4g0LfQsCDQtNCy0LAg0YjQsNCz0LAg0LTQviDQtNC+0LvQs9C+0LbQtNCw0L3QvdC+0LPQviDRgNC10LfRg9C70YzRgtCw0YLQsCDRh9GC0L4t0YLQviDRgdC70YPRh9Cw0LvQvtGB0Ywg0Lgg0LLRiyDQvdC40YfQtdCz0L4g0L3QtSDQtNC+0YHRgtC40LPQsNC70Lg/INCY0LvQuCDQt9Cw0YDQsNC90LXQtSDQtNGD0LzQsNC70Lg6IMKr0JLRgdC1INGA0LDQstC90L4g0YMg0LzQtdC90Y8g0L3QuNGH0LXQs9C+INC90LUg0L/QvtC70YPRh9C40YLRgdGPIcK7IOKAkyDQuCDQtNCw0LbQtSDQvdC1INC90LDRh9C40L3QsNC70Lgg0YDQtdCw0LvQuNC30L7QstGL0LLQsNGC0Ywg0YHQstC+0Y4g0LzQtdGH0YLRgz8g0JjQu9C4IMKr0LLRi9GF0L7QtNC40LvQuCDQuNC3INC40LPRgNGLwrssINC/0L7RgtC10YDRj9CyINC40L3RgtC10YDQtdGBLCDQv9GA0Lgg0L/QtdGA0LLRi9GFINC20LUg0LTQvtGB0YLQuNC20LXQvdC40Y/RhT8g0K3RgtC+INC90LUg0LXRgdGC0Ywg0YXQvtGA0L7RiNC+ISAKCuKchdCd0LAg0YHRgtCw0YDRgtC+0LLQvtC5INC/0LvQvtGJ0LDQtNC60LUg0Log0YPRgdC/0LXRhdGDLCDQutCw0Log0L/RgNCw0LLQuNC70L4sINC80Ysg0LLRgdC1INCy0LTRgNGD0LMg0L3QsNGH0LjQvdCw0LXQvCDQsdC+0Y/RgtGM0YHRj+KApiDQv9C10YDQtdC80LXQvS4g0J7QtNC90Lgg0LHRi9GB0YLRgNC+INC+0YLQsdGA0LDRgdGL0LLQsNGO0YIg0YHQvtC80L3QtdC90LjRjyDQuCDQvNGH0LDRgtGB0Y8g0LLQv9C10YDQtdC0INC90LAg0LrRgNGL0LvRjNGP0YUg0L/QvtCx0LXQtNGLLiDQlNGA0YPQs9C40LUgKNC30L3QsNGH0LjRgtC10LvRjNC90L7QtSDQsdC+0LvRjNGI0LjQvdGB0YLQstC+KSDQvdCw0YfQuNC90LDRjtGCINC90LUg0YHQv9Cw0YLRjCDQvdC+0YfQsNC80LgsINC80YPRh9C40YLRjNGB0Y8g0Lgg0L/QtdGA0LXQttC40LLQsNGC0YwuCgrinIUg0JfQsNGA0LDQvdC10LUg0LLQuNC30YPQsNC70LjQt9C40YDRg9C50YLQtSDRgdCy0L7RjiDQvdC+0LLRg9GOINC20LjQt9C90Ywg0L/QvtGB0LvQtSDQtNC+0YHRgtC40LbQtdC90LjRjyDQttC10LvQsNC10LzQvtCz0L4g0YDQtdC30YPQu9GM0YLQsNGC0LAuINCf0YDQtdC00YHRgtCw0LLRjNGC0LUg0YHQtdCx0Y8g0LIg0LHRg9C00YPRidC10Lwg0YfQtdGA0LXQtyDQv9GP0YLRjCDQu9C10YIg4oCTINC60LDQuiDQstGL0LPQu9GP0LTQuNGCINCy0LDRiNC1INC+0LrRgNGD0LbQtdC90LjQtT8g0JPQtNC1INC4INGBINC60LXQvCDQstGLINC20LjQstC10YLQtSwg0L3QsCDRh9C10Lwg0LXQt9C00LjRgtC1LCDQs9C00LUg0Lgg0LrQsNC6INC+0YLQtNGL0YXQsNC10YLQtT8g0JrQsNC60LjQtSDRgyDQstCw0YEg0L7RgtC90L7RiNC10L3QuNGPINGBINGA0L7QtNGB0YLQstC10L3QvdC40LrQsNC80Lgg0Lgg0LTRgNGD0LfRjNGP0LzQuD8g0J7RgtC60LDQt9Cw0LvQuNGB0Ywg0LvQuCDQstGLINC+0YIg0L7QsdGJ0LXQvdC40Y8g0YEg0L/QtdGB0YHQuNC80LjRgdGC0LDQvNC4LCDRgtGP0L3Rg9GJ0LjQvNC4INCy0LDRgSDQstC90LjQtz8KCuKchSDRgtC10L/QtdGA0Ywg0YHQv9GA0L7RgdC40YLQtSDCq9Cx0YPQtNGD0YnQtdCz0L4g0YHQtdCx0Y/Cuywg0LPQu9GP0LTRjyDQvdCw0LfQsNC0LCDQutCw0Log0LLRiyDQtNC+0LHQuNC70LjRgdGMINGC0LDQutC+0LPQviDRg9GB0L/QtdGF0LA/INCn0LXRgNC10Lcg0YfRgtC+INCy0Ysg0L/RgNC+0YjQu9C4PyDQp9C10Lwg0L/QvtC20LXRgNGC0LLQvtCy0LDQu9C4PyDQntGCINGH0LXQs9C+INC+0YLQutCw0LfQsNC70LjRgdGMPyDQmCDQv9C+0LTRgNC+0LHQvdC+INGA0LDRgdC/0LjRiNC40YLQtSDQvdCw0LfQsNC0INC/0L4g0LPQvtC00LDQvCwg0YfRgtC+INC40LzQtdC90L3QviDQstGLINGB0LTQtdC70LDQu9C4LCDRh9GC0L7QsdGLINC+0LrQsNC30LDRgtGM0YHRjyDQvdCwINCy0LXRgNGI0LjQvdC1LiDQotC10L/QtdGA0Ywg0YMg0LLQsNGBINC10YHRgtGMINC/0LvQsNC9INC00LXQudGB0YLQstC40Lkg0L3QsCDQsdC70LjQttCw0LnRiNC40LUg0L/Rj9GC0Ywg0LvQtdGCLiDQoNC10LPRg9C70Y/RgNC90L4g0LLQvtC30LLRgNCw0YnQsNC50YLQtdGB0Ywg0Log0YHQstC+0LXQuSDQvNC10YfRgtC1IOKAkyDQutC+0YDRgNC10LrRgtC40YDRg9C50YLQtSDQuCDQtNC+0YHRgtGA0LDQuNCy0LDQudGC0LUg0LbQtdC70LDQvdC90YvQuSDQvtCx0YDQsNC3LiDQmCDRgNC10LDQu9C40LfQvtCy0YvQstCw0LnRgtC1INC/0LvQsNC9INC00LXQudGB0YLQstC40LksINGH0YLQvtCx0Ysg0YHRgtCw0YLRjCDQuNC80LXQvdC90L4g0YLQsNC60LjQvCwg0LrQsNC6INCy0Ysg0YXQvtGC0LjRgtC1LgoK4pyFINCS0LDRiNCwINC/0YDQvtCx0LvQtdC80LAg0L/RgNC+0Y/QstC70Y/QtdGC0YHRjyDQsiDQs9C70YPQsdC40L3QvdC+0Lwg0YPQsdC10LbQtNC10L3QuNC4IMKr0K8g0L3QsCDRgdCw0LzQvtC8INC00LXQu9C1INC90LjRh9C10LPQviDQuNC3INGB0LXQsdGPINC90LUg0L/RgNC10LTRgdGC0LDQstC70Y/RjsK7INC4INC90LXQstC10YDQuNC4INCyINGB0LXQsdGPLCDQutC+0YLQvtGA0L7QtSDQvdC1INC80LXQvdGP0LXRgtGB0Y8g0LTQsNC20LUg0L/QvtC0INCy0LvQuNGP0L3QuNC10Lwg0YDQtdCw0LvRjNC90YvRhSDQtNC+0YHRgtC40LbQtdC90LjQuS4g0KfQtdC70L7QstC10Log0L/QvtGB0YLQvtGP0L3QvdC+INC40YHQv9GL0YLRi9Cy0LDQtdGCINGC0YDQtdCy0L7Qs9GDINC4INC+0LHQtdGB0YbQtdC90LjQstCw0LXRgiDQu9GO0LHRi9C1INGB0LLQvtC4INGD0YHQv9C10YXQuC4KCuKchSDQrdGC0LAg0L/RgNC+0LHQu9C10LzQsCDQv9GA0L7Rj9Cy0LvRj9C10YLRgdGPINCyINCz0LvRg9Cx0LjQvdC90L7QvCDRg9Cx0LXQttC00LXQvdC40LggwqvQryDQvdCwINGB0LDQvNC+0Lwg0LTQtdC70LUg0L3QuNGH0LXQs9C+INC40Lcg0YHQtdCx0Y8g0L3QtSDQv9GA0LXQtNGB0YLQsNCy0LvRj9GOwrsg0Lgg0L3QtdCy0LXRgNC40Lgg0LIg0YHQtdCx0Y8sINC60L7RgtC+0YDQvtC1INC90LUg0LzQtdC90Y/QtdGC0YHRjyDQtNCw0LbQtSDQv9C+0LQg0LLQu9C40Y/QvdC40LXQvCDRgNC10LDQu9GM0L3Ri9GFINC00L7RgdGC0LjQttC10L3QuNC5LiDQp9C10LvQvtCy0LXQuiDQv9C+0YHRgtC+0Y/QvdC90L4g0LjRgdC/0YvRgtGL0LLQsNC10YIg0YLRgNC10LLQvtCz0YMg0Lgg0L7QsdC10YHRhtC10L3QuNCy0LDQtdGCINC70Y7QsdGL0LUg0YHQstC+0Lgg0YPRgdC/0LXRhdC4CgrinIUg0JfQsNCy0LXQtNC40YLQtSDRgdC10LHQtSDCq9GC0LXRgtGA0LDQtNGMINC00L7RgdGC0LjQttC10L3QuNC5wrsuINCV0LbQtdC00L3QtdCy0L3QviDQstC10YfQtdGA0L7QvCDQv9C10YDQtdC0INGB0L3QvtC8INC30LDQv9C40YHRi9Cy0LDQudGC0LUsINC60LDQutC40LUg0YPRgdC/0LXRhdC4INC4INC/0L7QsdC10LTRiyDQsdGL0LvQuCDRgyDQstCw0YEg0LTQvdC10LwuINCf0LXRgNCy0L7QtSDQstGA0LXQvNGPINCy0LDQvCDQsdGD0LTQtdGCINC90LXQu9C10LPQutC+INC/0YDQuNC30L3QsNGC0YwsINGH0YLQviDQvNC90L7Qs9C+0LUg0L/QvtC70YPRh9Cw0LXRgtGB0Y8g0LjQvNC10L3QvdC+INCx0LvQsNCz0L7QtNCw0YDRjyDQstCw0YjQuNC8INGD0YHQuNC70LjRj9C8LiDQn9C+0YLQvtC8INCy0Ysg0L3QsNGH0L3QtdGC0LUg0YbQtdC90LjRgtGMINGB0L7QsdGB0YLQstC10L3QvdGL0LUg0LfQsNGB0LvRg9Cz0LgKCtCg0LDQt9GA0LXRiNC40YLQtSDRgdC10LHQtSDQvtGI0LjQsdCw0YLRjNGB0Y8uINCS0Ysg0L3QtSDQvtCx0Y/Qt9Cw0L3RiyDQstGB0LUg0YPQvNC10YLRjCDQuCDQstGB0LXQs9C00LAg0LfQvdCw0YLRjCDQv9GA0LDQstC40LvRjNC90YvQuSDQvtGC0LLQtdGCLiDQo9GH0LjRgtC10YHRjCDQv9GA0L7RidCw0YLRjCDRgdC10LHRjyDQt9CwINC/0YDQvtGB0YfQtdGC0YsuINCR0LXQtyDQvdC10YPQtNCw0Ycg0L3QtdCy0L7Qt9C80L7QttC90L4g0L3QuNGH0LXQvNGDINC90LDRg9GH0LjRgtGM0YHRjyDQuCDQvdC40YfQtdCz0L4g0LTQvtGB0YLQuNGH0YwuINCS0YHQv9C+0LzQvdC40YLQtSDRgdC60L7Qu9GM0LrQviDRgNCw0Lcg0JLRiyDQv9Cw0LTQsNC70LgsINC/0YDQtdC20LTQtSDRh9C10Lwg0L3QsNGD0YfQuNC70LjRgdGMINC10LfQtNC40YLRjCDQvdCwINCy0LXQu9C+0YHQuNC/0LXQtNC1PwoK4p2X77iPINCYINC/0L7QvNC90LjRgtC1OiAK0J3QtSDQv9GA0LjQvdC40LzQsNC50YLQtSDQutGA0LjRgtC40LrRgyDRgdC70LjRiNC60L7QvCDQsdC70LjQt9C60L4sINCe0YLQvdC+0YHQuNGC0LXRgdGMINC6INC60YDQuNGC0LjQutC1INGB0L/QvtC60L7QudC90L4sINGA0YPQutC+0LLQvtC00YHRgtCy0YPQudGC0LXRgdGMINGE0LDQutGC0LDQvNC4LiDQmCDRgtC+0LPQtNCwINGDINCS0LDRgSDQstGB0ZEg0L/QvtC70YPRh9C40YLRgdGPIPCfmY8=',
        1, 0, 676244920, 4490, '04:35:11'),
       (244, 600927662,
        '0JrQsNC6INC/0LXRgNC10YHRgtCw0YLRjCDRgNGD0LPQsNGC0YzRgdGPINC40Lct0LfQsCDQvNC10LvQvtGH0LXQuSDRgSDQtNC+0YDQvtCz0LjQvNC4INC80L3QtSDQu9GO0LTRjNC80LgsINC60L7Qs9C00LAg0LzRiyDQvdCwINGA0LDRgdGB0YLQvtGP0L3QuNC4',
        '0JzQvdC+0LPQuNC1INC90LUg0LLQtdGA0Y/Rgiwg0YfRgtC+INC70Y7QsdC+0LLRjCDQvNC+0LbQtdGCINC/0L7QtNC00LXRgNC20LjQstCw0YLRjCDQtNC40YHRgtCw0L3RhtC40L7QvdC90L4uINCh0YPRidC10YHRgtCy0YPQtdGCINC80L3QvtCz0L4g0LLQsNGA0LjQsNC90YLQvtCyLCDRh9GC0L4g0LHRiyDRh9GD0LLRgdGC0LLQsCDQtNCw0LbQtSDQvdCwINGA0LDRgdGB0YLQvtGP0L3QuNC4INC90LUg0L7RhdC70LDQtNC10LvQuC4KCuKchSDQn9C+0LTQtNC10YDQttC40LLQsNC50YLQtSDQvtCx0YnQtdC90LjQtSDQutCw0Log0LzQvtC20L3QviDRh9Cw0YnQtSwg0L/RgNC4INC/0L7QvNC+0YnQuCDQt9Cy0L7QvdC60L7QsiwgU01TIC0g0YHQvtC+0LHRidC10L3QuNC5LCBTa3lwZSAo0LLQsNGA0LjQsNC90YLQvtCyINC80L3QvtCz0L4pLiDQndGD0LbQvdC+INC30LDQvdC40LzQsNGC0Ywg0LLQsNC20L3QvtC1INC80LXRgdGC0L4g0LIg0LXQttC10LTQvdC10LLQvdC+0Lkg0LbQuNC30L3QuCDQtNGA0YPQsyDQtNGA0YPQs9CwLgoK4pyFINCSINGB0LDQvNC+0Lwg0L3QsNGH0LDQu9C1INC+0YLQvdC+0YjQtdC90LjQuSDQt9Cw0LTQsNC50YLQtSDQtNGA0YPQsyDQtNGA0YPQs9GDINCy0LDQttC90YvQtSDQstC+0L/RgNC+0YHRiywg0YfRgtC+0LHRiyDRg9C00L7RgdGC0L7QstC10YDQuNGC0YzRgdGPLCDRh9GC0L4g0LLRiyDQvtCx0LAg0LbQtNGR0YLQtSDQvtGCINC90LjRhSDQvtC00L3QvtCz0L4g0Lgg0YLQvtCz0L4g0LbQtS4gINCT0L7RgtC+0LIg0LvQuCDQutGC0L4gLSDQu9C40LHQviDQuNC3INCS0LDRgSwg0LbQtNCw0YLRjC4g0K3RgtC+INC+0YfQtdC90Ywg0LLQsNC20L3QviEgCgrinIUg0JHRgNC+0YHRjNGC0LUg0LLRi9C30L7QsiDRgNCw0YHRgdGC0L7Rj9C90LjRjiDQuCDQtNC10LvQsNC50YLQtSDQstC80LXRgdGC0LUg0LrQsNC60LjQtSDRgtC+INC00LXQu9CwLiAg0J3QsNC/0YDQuNC80LXRgCwg0L/QvtGB0LzQvtGC0YDQuNGC0LUg0L7QtNC90L7QstGA0LXQvNC10L3QvdC+INC+0LTQvdGDINC4INGC0YMg0LbQtSDQv9C10YDQtdC00LDRh9GDINC40LvQuCDRhNC40LvRjNC8LCDQv9GA0LjQvdC40LzQsNC50YLQtSDQsiDQuNCz0YDRgyDQv9C+INGB0LXRgtC4LCDQs9C+0YLQvtCy0YzRgtC1INGD0LbQuNC9LCDRgNCw0LfQs9C+0LLQsNGA0LjQstCw0Y8g0L/RgNC4INGN0YLQvtC8INC/0L4g0LLQuNC00LXQvi3Qt9Cy0L7QvdC60YMsINC/0L7Rh9C40YLQsNC50YLQtSDQutC90LjQs9GDLCDQvtCx0YHRg9C00LjRgtC1INC60LDQttC00YvQuSDRgdCy0L7RkSDQvNC90LXQvdC40LUuIAoK4pyFINCg0LDRgdGB0LrQsNC30YvQstCw0LnRgtC1INC+INC/0YDQvtC40YHRhdC+0LTRj9GJ0LXQvCDQsiDRgtC10YfQtdC90LjQtSDQtNC90Y8sINC80LXQu9C60LjRhSDQv9C+0LHQtdC00LDRhSwg0YDQsNC00L7RgdGC0Y/RhSDQuCDQutC+0L3QtdGH0L3QviDQttC1INC4INC+INC/0YDQvtCx0LvQtdC80LDRhS4g0JLQsNC20L3QviDQv9C+0LTQtNC10YDQttC40LLQsNGC0Ywg0Y3QvNC+0YbQuNC+0L3QsNC70YzQvdGD0Y4g0YHQstGP0LfRjC4KCuKchSDQndC1INC30LDQsdGL0LLQsNC50YLQtSDQuCDQviDQv9GA0LXQuNC80YPRidC10YHRgtCy0LDRhSwg0LrQvtGC0L7RgNGL0LUg0LTQsNGO0YIg0L7RgtC90L7RiNC10L3QuNGPINC90LAg0YDQsNGB0YHRgtC+0Y/QvdC40Lg6INC80LXQvdGM0YjQtSDQsdGL0YLQvtCy0YvRhSDQv9GA0L7QsdC70LXQvCwg0LLQvtC30LzQvtC20L3QvtGB0YLRjCDQv9GA0L7QstC+0LTQuNGC0Ywg0LHQvtC70YzRiNC1INCy0YDQtdC80LXQvdC4INGBINGB0LXQvNGM0ZHQuSwg0YEg0LTRgNGD0LfRjNGP0LzQuCwg0LLQvtC30LzQvtC20L3QvtGB0YLRjCDQt9Cw0L3Rj9GC0YzRgdGPINGB0L7QsdC+0LkuCgrinIUg0J3QtSDQt9Cw0LHRi9Cy0LDQudGC0LUg0L7QsdGB0YPQttC00LDRgtGMINCS0LDRiNC4INGB0L7QstC80LXRgdGC0L3Ri9C1INC/0LvQsNC90Ysg0L3QsCDQsdGD0LTRg9GJ0LXQtSwg0YfRgtC+0LHRiyDQt9C90LDRgtGMLCDRgNCw0LTQuCDRh9C10LPQviDQstGLINGB0YLQsNGA0LDQtdGC0LXRgdGMINC4INC/0LXRgNC10LbQuNCy0LDQtdGC0LUg0YLRgNGD0LTQvdC+0YHRgtC4INC4INC/0YDQvtCx0LvQtdC80Ysg0L7RgtC90L7RiNC10L3QuNC5INC90LAg0YDQsNGB0YHRgtC+0Y/QvdC40LguCgrinZfvuI/QmCDQv9C+0LzQvdC40YLQtToK0JTQsNC20LUg0YHQsNC80L7QtSDQsdC+0LvRjNGI0L7QtSDRgNCw0YHRgdGC0L7Rj9C90LjQtSAtINC00LvRjyDQu9GO0LHRj9GJ0LjRhSDQv9GA0LXQvtC00L7Qu9C40LzQvi4g8J+Zjw==',
        1, 0, 676244920, 4495, '04:37:45'),
       (245, 555180260,
        '0JzQtdC90Y8g0LLRgdC1INGD0L3QuNC20LDRjtGCINC00L7QvNCwINC+0YIg0LzQtdC90Y8g0LLRgdC1INCx0LXRgNC10YIg0LfQu9C+0YHRgtGMINC/0L7RgtC+0LzRg9GI0YLQviDRjyDRgdCw0LzQsNGPINC80LDQu9C10L3RjNC60LDRjyDQtNC10LLQvtGH0LrQsCDQstC+0YIg0Lgg0LzQvdC1INC+0LHQuNC00L3Qvg==',
        '0K3QvNC+0YbQuNC+0L3QsNC70YzQvdC+0LUg0L3QsNGB0LjQu9C40LUg0LLRgdGC0YDQtdGH0LDQtdGC0YHRjyDQvdCw0LzQvdC+0LPQviDRh9Cw0YnQtSwg0YfQtdC8INGE0LjQt9C40YfQtdGB0LrQvtC1LCDQuCDQvtGB0YLQsNCy0LvRj9C10YIg0L3QtSDQvNC10L3QtdC1INCz0LvRg9Cx0L7QutC40LUg0YHQu9C10LTRiywg0L/Rg9GB0YLRjCDQtNCw0LbQtSDQvtC90Lgg0Lgg0L3QtdC30LDQvNC10YLQvdGLINCz0LvQsNC30YMuCgrinIXQldGB0LvQuCDQstGLINC/0L7QtNCy0LXRgNCz0LDQtdGC0LXRgdGMINGC0LDQutC+0LzRgyDQvdCw0YHQuNC70LjRjiDRgdC+INGB0YLQvtGA0L7QvdGLINGA0L7QtNC40YLQtdC70LXQuSwg0YHQsNC80L7QtSDQtNC10LnRgdGC0LLQtdC90L3QvtC1IOKAlCDRjdGC0L4g0YPRgdGC0LDQvdC+0LLQuNGC0Ywg0LTQu9GPINGB0LXQsdGPINCz0YDQsNC90LjRhtGLINC4INC/0L4g0LLQvtC30LzQvtC20L3QvtGB0YLQuCDRgdC+0YXRgNCw0L3Rj9GC0Ywg0LTQuNGB0YLQsNC90YbQuNGOLiDQotCw0LrQttC1INC/0L7Qu9C10LfQvdC+INC40LzQtdGC0Ywg0LLQvtC30LzQvtC20L3QvtGB0YLRjCDQv9C+0LTQtdC70LjRgtGM0YHRjyDQv9GA0L7QuNGB0YXQvtC00Y/RidC40Lwg0YEg0LrQtdC8LdGC0L4sINC60L7QvNGDINCy0Ysg0LTQvtCy0LXRgNGP0LXRgtC1LiDQmtGA0L7QvNC1INGC0L7Qs9C+LCDRgdGC0L7QuNGCINC90LDRg9GH0LjRgtGM0YHRjyDQutC+0L3RgtGA0L7Qu9C40YDQvtCy0LDRgtGMINGB0YLRgNC10YHRgSDQuCDRg9C60YDQtdC/0LjRgtGMINGB0LLQvtGOINGB0LDQvNC+0L7RhtC10L3QutGDLCDRh9GC0L7QsdGLINGB0L/RgNCw0LLQu9GP0YLRjNGB0Y8g0YEg0YHQuNGC0YPQsNGG0LjQtdC5INC60LDQuiDQvdC10LzQtdC00LvQtdC90L3Qviwg0YLQsNC6INC4INCyINC00L7Qu9Cz0L7RgdGA0L7Rh9C90L7QvCDQv9C70LDQvdC1LgoK4pyF0JLRiyDQvdCw0LLQtdGA0L3Rj9C60LAg0LfQvdCw0LXRgtC1INGC0YDQuNCz0LPQtdGA0YsgKNGA0LDQt9C00YDQsNC20LjRgtC10LvQuCksINC60L7RgtC+0YDRi9C1INC80L7Qs9GD0YIgwqvQt9Cw0LLQtdGB0YLQuMK7INCy0LDRiNC40YUg0YDQvtC00LjRgtC10LvQtdC5LiDQndCw0YPRh9C40YLQtdGB0Ywg0YDQsNGB0L/QvtC30L3QsNCy0LDRgtGMINC40YUsINGH0YLQvtCx0Ysg0L3QtSDQtNC+0L/Rg9GB0LrQsNGC0Ywg0YLQsNC60LjRhSDRgdC40YLRg9Cw0YbQuNC5INC40LvQuCDRgdCy0L7QtdCy0YDQtdC80LXQvdC90L4g0YPQutC70L7QvdGP0YLRjNGB0Y8g0L7RgiDQvtGB0LrQvtGA0LHQu9C10L3QuNC5LsKgCgrinIXQl9C00L7RgNC+0LLQsNGPINGB0LDQvNC+0L7RhtC10L3QutCwIOKAlCDRjdGC0L4g0LvRg9GH0YjQtdC1INC/0YDQvtGC0LjQstC+0LTQtdC50YHRgtCy0LjQtSDQvNC+0YDQsNC70YzQvdC+0LzRgyDQvdCw0YHQuNC70LjRji4g0JTQu9GPINGA0LXRiNC10L3QuNGPINC/0YDQvtCx0LvQtdC80Ysg0L/RgNC+0LLQvtC00LjRgtC1INCx0L7Qu9GM0YjQtSDQstGA0LXQvNC10L3QuCDRgSDRhdC+0YDQvtGI0LjQvNC4INC00YDRg9C30YzRj9C80LgsINC00L7QsdGA0YvQvNC4INGA0L7QtNGB0YLQstC10L3QvdC40LrQsNC80Lgg0Lgg0LTRgNGD0LPQuNC80Lgg0LvRjtC00YzQvNC4LCDQutC+0YLQvtGA0YvQtSDQtNC10LvQsNGO0YIg0LLQsNGBINGB0LjQu9GM0L3QtdC1INC4INGD0LLQtdGA0LXQvdC90LXQtS4KCuKchdCi0LDQutC20LUg0LzQvtC20L3QviDQt9Cw0L3QuNC80LDRgtGM0YHRjyDRgtC10LwsINGH0YLQviDRgyDQstCw0YEg0YXQvtGA0L7RiNC+INC/0L7Qu9GD0YfQsNC10YLRgdGPLiDQodGC0LDQvdGM0YLQtSDRg9GH0LDRgdGC0L3QuNC60L7QvCDRgdC/0L7RgNGC0LjQstC90L7QuSDQutC+0LzQsNC90LTRiyDQuNC70Lgg0LzQvtC70L7QtNC10LbQvdC+0LPQviDQtNCy0LjQttC10L3QuNGPINCyINGI0LrQvtC70LUg0LjQu9C4INCyINC+0LHRidC10YHRgtCy0LXQvdC90L7QuSDQvtGA0LPQsNC90LjQt9Cw0YbQuNC4LiDQotCw0Log0LLRiyDQvdC1INGC0L7Qu9GM0LrQviDQvdCw0YPRh9C40YLQtdGB0Ywg0YbQtdC90LjRgtGMINGB0LXQsdGPLCDQvdC+INC4INC90LDRh9C90LXRgtC1INGH0LDRidC1INCy0YvRhdC+0LTQuNGC0Ywg0LjQtyDQtNC+0LzQsC4KCuKchdCd0LXRgiDRgdC+0LzQvdC10L3QuNC5INCyINGC0L7QvCwg0YfRgtC+INGN0LzQvtGG0LjQvtC90LDQu9GM0L3QvtC1INC90LDRgdC40LvQuNC1INC/0YDQuNCy0L7QtNC40YIg0Log0YHQuNC70YzQvdC+0LzRgyDRgdGC0YDQtdGB0YHRgyDQuCDQtNCw0LbQtSDQv9C+0YHRgtC+0Y/QvdC90YvQvCDQv9GA0L7QsdC70LXQvNCw0Lwg0LLRgNC+0LTQtSAg0LTQtdC/0YDQtdGB0YHQuNC4LgoK4pyFINCX0LTQvtGA0L7QstGL0LUg0YLQtdGF0L3QuNC60LjCoNC+0YHQu9Cw0LHQu9C10L3QuNGPINGB0YLRgNC10YHRgdCwwqDQstGA0L7QtNC1wqDQvNC10LTQuNGC0LDRhtC40LgswqDQs9C70YPQsdC+0LrQvtCz0L4g0LTRi9GF0LDQvdC40Y/CoNC4wqDQudC+0LPQuCwg0L/QvtC30LLQvtC70Y/RgiDQstCw0Lwg0YPRgdC/0L7QutC+0LjRgtGM0YHRjyDQuCDRh9GD0LLRgdGC0LLQvtCy0LDRgtGMINGB0LXQsdGPINCx0L7Qu9C10LUg0YHQvtCx0YDQsNC90L3Ri9C8LgoK4p2X77iPINCYINC/0L7QvNC90LjRgtC1OiAK0JrQsNC20LTRi9C5INC00L7RgdGC0L7QuNC9INC70Y7QsdCy0LgsINC30LDQsdC+0YLRiyDQuCDRg9Cy0LDQttC10L3QuNGPLvCfmY8=',
        1, 0, 676244920, 4499, '05:06:15'),
       (246, 3564230,
        '0KHRgtC+0LjRgiDQu9C4INC00LDQstCw0YLRjCDQsdGL0LLRiNC10LzRgyDQstGC0L7RgNC+0Lkg0YjQsNC90YEsINC10YHQu9C4INC+0L0g0L7RgdGC0LDQstC40Lsg0YLQtdCx0Y8g0L/QvtC70LPQvtC00LAg0L3QsNC30LDQtCDQsdC10Lcg0L7QsdGK0Y/RgdC90LXQvdC40Y8g0L/RgNC40YfQuNC90YssINC4INGB0L/Rg9GB0YLRjyDRgdGC0L7Qu9GM0LrQviDQstGA0LXQvNC10L3QuCDQvtC9INC+0LHRitGP0LLQu9GP0LXRgtGB0Y8g0Lgg0LPQvtCy0L7RgNC40YIsINGH0YLQviDQtNC10LvQviDQsdGL0LvQviDQsiDRgtC+0LwsINGH0YLQviDRgyDQvdC10LPQviDQvdCw0YfQsNC70LjRgdGMINC/0LDQvdC40YfQtdGB0LrQuNC1INCw0YLQsNC60Lg=',
        NULL, 0, 0, 0, 0, '08:43:37'),
       (247, 572122329,
        '0JrQsNC6INCy0LvRjtCx0LjRgtGMINCyINGB0LXQsdGPINC+0LHRgNCw0YLQvdC+INC00LXQstGD0YjQutGDINC60L7RgtC+0YDQsNGPINGB0YLQsNGA0YjQtSDRgtC10LHRjw==',
        NULL, 0, 0, 0, 0, '08:44:13'),
       (248, 1155437332, '0JrQsNC6INC/0YDQuNC30L3QsNGC0YzRgdGPINC/0LDRgNC90Y4g0L7QsSDQuNC30LzQtdC90LU/', NULL, 0, 0, 0,
        0, '10:09:34'),
       (249, 522673022, '0KXQvtGH0LXRiNGMINC70Lgg0YLRiyDRgdC+INC80L3QvtC5INC00YDRg9C20LjRgtGMPw==', NULL, 0, 0, 0, 0,
        '10:13:48'),
       (250, 555180260,
        '0K8g0YXQvtGH0YMg0YHRgtCw0YLRjCDQsNC60YLRgNC+0Lkg0L3QviDQs9C+0LLQvtGA0Y/RgiAg0YfRgtC+INGN0YLQviDQvdC1INGF0L7RgNC+0YjQsNGPINC/0YDQvtGE0LXRgdGB0LjRjyDRgNGD0LPQsNGO0YIg0Lgg0LPQvtCy0L7RgNGP0YIg0YLQtdCx0LUg0L3QtSDQv9C+0LTRhdC+0LTQuNGC',
        NULL, 0, 0, 0, 0, '10:42:01');

-- --------------------------------------------------------

--
-- Структура таблицы `users`
--

CREATE TABLE `users`
(
    `id`        int(11) NOT NULL,
    `data_json` longtext COLLATE utf8_unicode_ci DEFAULT NULL,
    `chatID`    int(11) NOT NULL
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE = utf8_unicode_ci;

--
-- Дамп данных таблицы `users`
--

INSERT INTO `users` (`id`, `data_json`, `chatID`)
VALUES (9,
        '{\"step\":10,\"page\":0,\"lastMessageId\":4542,\"gender\":\"Мужчина\",\"age\":\"19-20\",\"answerType\":\"Текст\"}',
        635793263),
       (10,
        '{\"step\":2,\"page\":0,\"lastMessageId\":null,\"gender\":\"Мужчина\",\"age\":\"17-18\",\"answerType\":\"Текст\"}',
        583412087),
       (11,
        '{\"step\":0,\"page\":0,\"lastMessageId\":4394,\"gender\":\"Мужчина\",\"age\":\"17-18\",\"answerType\":\"Текст\"}',
        659785305),
       (12, '{\"step\":\"main_page\",\"page\":0,\"lastMessageId\":2779}', 676244920),
       (13, '{\"step\":\"main_page\",\"page\":0,\"lastMessageId\":2796}', 229583127),
       (14,
        '{\"step\":2,\"page\":0,\"lastMessageId\":null,\"gender\":\"Женщина\",\"age\":\"17-18\",\"answerType\":\"Аудио\"}',
        99949),
       (15, '{\"step\":2,\"page\":0,\"lastMessageId\":2959,\"gender\":\"Женщина\"}', 540525212),
       (16,
        '{\"step\":2,\"page\":0,\"lastMessageId\":null,\"gender\":\"Мужчина\",\"age\":\"17-18\",\"answerType\":\"Текст\"}',
        756865095),
       (17,
        '{\"step\":8,\"page\":0,\"lastMessageId\":3011,\"gender\":\"Женщина\",\"age\":\"19-20\",\"answerType\":\"Аудио\"}',
        317898747),
       (18, '{\"step\":7,\"page\":0,\"lastMessageId\":null,\"gender\":\"Женщина\",\"age\":\"17-18\"}', 311722312),
       (19,
        '{\"step\":2,\"page\":0,\"lastMessageId\":3142,\"gender\":\"Мужчина\",\"age\":\"17-18\",\"answerType\":\"Текст\"}',
        3204942),
       (20, '{\"step\":7,\"page\":0,\"lastMessageId\":null,\"gender\":\"Мужчина\",\"age\":\"19-20\"}', 554456762),
       (21,
        '{\"step\":2,\"page\":0,\"lastMessageId\":null,\"gender\":\"Женщина\",\"age\":\"19-20\",\"answerType\":\"Текст\"}',
        960442310),
       (22,
        '{\"step\":2,\"page\":0,\"lastMessageId\":null,\"gender\":\"Мужчина\",\"age\":\"19-20\",\"answerType\":\"Текст\"}',
        717168179),
       (23,
        '{\"step\":2,\"page\":0,\"lastMessageId\":null,\"gender\":\"Женщина\",\"age\":\"14-16\",\"answerType\":\"Текст\"}',
        1032015145),
       (24,
        '{\"step\":2,\"page\":0,\"lastMessageId\":null,\"gender\":\"Мужчина\",\"age\":\"14-16\",\"answerType\":\"Текст\"}',
        551855601),
       (25,
        '{\"step\":6,\"page\":0,\"lastMessageId\":3244,\"gender\":\"Мужчина\",\"age\":\"19-20\",\"answerType\":\"Аудио\"}',
        275325587),
       (26,
        '{\"step\":2,\"page\":0,\"lastMessageId\":null,\"gender\":\"Женщина\",\"age\":\"19-20\",\"answerType\":\"Текст\"}',
        846380304),
       (27,
        '{\"step\":2,\"page\":0,\"lastMessageId\":3312,\"gender\":\"Женщина\",\"age\":\"19-20\",\"answerType\":\"Аудио\"}',
        797506012),
       (28,
        '{\"step\":2,\"page\":0,\"lastMessageId\":null,\"gender\":\"Женщина\",\"age\":\"14-16\",\"answerType\":\"Текст\"}',
        434527211),
       (29, '{\"step\":0,\"page\":0,\"lastMessageId\":3260}', 993748010),
       (30,
        '{\"step\":10,\"page\":0,\"lastMessageId\":3271,\"gender\":\"Мужчина\",\"age\":\"17-18\",\"answerType\":\"Аудио\"}',
        1097658320),
       (31,
        '{\"step\":2,\"page\":0,\"lastMessageId\":null,\"gender\":\"Мужчина\",\"age\":\"19-20\",\"answerType\":\"Текст\"}',
        882229648),
       (32,
        '{\"step\":2,\"page\":0,\"lastMessageId\":null,\"gender\":\"Женщина\",\"age\":\"19-20\",\"answerType\":\"Текст\"}',
        636263753),
       (33, '{\"step\":\"main_page\",\"page\":0,\"lastMessageId\":null}', 787113560),
       (34, '{\"step\":7,\"page\":0,\"lastMessageId\":null,\"gender\":\"Мужчина\",\"age\":\"17-18\"}', 674649801),
       (35,
        '{\"step\":2,\"page\":0,\"lastMessageId\":null,\"gender\":\"Женщина\",\"age\":\"17-18\",\"answerType\":\"Текст\"}',
        1004239252),
       (36, '{\"step\":\"main_page\",\"page\":0,\"lastMessageId\":3350}', 848708807),
       (37, '{\"step\":7,\"page\":0,\"lastMessageId\":null,\"gender\":\"Мужчина\",\"age\":\"17-18\"}', 935355269),
       (38, '{\"step\":\"main_page\",\"page\":0,\"lastMessageId\":null}', 427326272),
       (39, '{\"step\":\"main_page\",\"page\":0,\"lastMessageId\":null}', 173269098),
       (40,
        '{\"step\":2,\"page\":0,\"lastMessageId\":3419,\"gender\":\"Мужчина\",\"age\":\"19-20\",\"answerType\":\"Текст\"}',
        482944903),
       (41,
        '{\"step\":2,\"page\":0,\"lastMessageId\":3410,\"gender\":\"Мужчина\",\"age\":\"19-20\",\"answerType\":\"Текст\"}',
        106529367),
       (42, '{\"step\":7,\"page\":0,\"lastMessageId\":null,\"gender\":\"Мужчина\",\"age\":\"19-20\"}', 675255392),
       (43,
        '{\"step\":2,\"page\":0,\"lastMessageId\":null,\"gender\":\"Мужчина\",\"age\":\"19-20\",\"answerType\":\"Текст\"}',
        457205880),
       (44, '{\"step\":7,\"page\":0,\"lastMessageId\":null,\"gender\":\"Женщина\",\"age\":\"19-20\"}', 1068623528),
       (45,
        '{\"step\":2,\"page\":0,\"lastMessageId\":3449,\"gender\":\"Женщина\",\"age\":\"19-20\",\"answerType\":\"Текст\"}',
        248886767),
       (46,
        '{\"step\":2,\"page\":0,\"lastMessageId\":null,\"gender\":\"Женщина\",\"age\":\"19-20\",\"answerType\":\"Текст\"}',
        281742814),
       (47,
        '{\"step\":2,\"page\":0,\"lastMessageId\":3457,\"gender\":\"Мужчина\",\"age\":\"19-20\",\"answerType\":\"Текст\"}',
        129815945),
       (48,
        '{\"step\":2,\"page\":0,\"lastMessageId\":null,\"gender\":\"Мужчина\",\"age\":\"17-18\",\"answerType\":\"Текст\"}',
        161892208),
       (49, '{\"step\":0,\"page\":0,\"lastMessageId\":3462}', 805916389),
       (50,
        '{\"step\":2,\"page\":0,\"lastMessageId\":3467,\"gender\":\"Мужчина\",\"age\":\"17-18\",\"answerType\":\"Аудио\"}',
        645048821),
       (51,
        '{\"step\":2,\"page\":0,\"lastMessageId\":null,\"gender\":\"Мужчина\",\"age\":\"19-20\",\"answerType\":\"Текст\"}',
        112672363),
       (52,
        '{\"step\":2,\"page\":0,\"lastMessageId\":3476,\"gender\":\"Женщина\",\"age\":\"19-20\",\"answerType\":\"Текст\"}',
        68360763),
       (53, '{\"step\":7,\"page\":0,\"lastMessageId\":null,\"gender\":\"Женщина\",\"age\":\"19-20\"}', 677571874),
       (54,
        '{\"step\":2,\"page\":0,\"lastMessageId\":null,\"gender\":\"Женщина\",\"age\":\"17-18\",\"answerType\":\"Аудио\"}',
        1091085901),
       (55,
        '{\"step\":2,\"page\":0,\"lastMessageId\":null,\"gender\":\"Женщина\",\"age\":\"19-20\",\"answerType\":\"Текст\"}',
        520383680),
       (56,
        '{\"step\":2,\"page\":0,\"lastMessageId\":null,\"gender\":\"Женщина\",\"age\":\"14-16\",\"answerType\":\"Текст\"}',
        1072187765),
       (57,
        '{\"step\":2,\"page\":0,\"lastMessageId\":null,\"gender\":\"Мужчина\",\"age\":\"19-20\",\"answerType\":\"Текст\"}',
        505565765),
       (58,
        '{\"step\":2,\"page\":0,\"lastMessageId\":3506,\"gender\":\"Мужчина\",\"age\":\"19-20\",\"answerType\":\"Текст\"}',
        243837881),
       (59,
        '{\"step\":2,\"page\":0,\"lastMessageId\":3526,\"gender\":\"Женщина\",\"age\":\"19-20\",\"answerType\":\"Аудио\"}',
        107821335),
       (60,
        '{\"step\":2,\"page\":0,\"lastMessageId\":null,\"gender\":\"Женщина\",\"age\":\"19-20\",\"answerType\":\"Текст\"}',
        452044227),
       (61, '{\"step\":7,\"page\":0,\"lastMessageId\":null,\"gender\":\"Женщина\",\"age\":\"17-18\"}', 184459546),
       (62,
        '{\"step\":7,\"page\":0,\"lastMessageId\":null,\"gender\":\"Женщина\",\"age\":\"17-18\",\"answerType\":\"Текст\"}',
        1033830722),
       (63, '{\"step\":\"main_page\",\"page\":0,\"lastMessageId\":3855}', 169053448),
       (64,
        '{\"step\":2,\"page\":0,\"lastMessageId\":4129,\"gender\":\"Женщина\",\"age\":\"17-18\",\"answerType\":\"Текст\"}',
        533221751),
       (65,
        '{\"step\":2,\"page\":0,\"lastMessageId\":null,\"gender\":\"Мужчина\",\"age\":\"19-20\",\"answerType\":\"Текст\"}',
        1008739),
       (66,
        '{\"step\":2,\"page\":0,\"lastMessageId\":null,\"gender\":\"Мужчина\",\"age\":\"14-16\",\"answerType\":\"Аудио\"}',
        59820536),
       (67,
        '{\"step\":2,\"page\":0,\"lastMessageId\":null,\"gender\":\"Женщина\",\"age\":\"14-16\",\"answerType\":\"Текст\"}',
        994403749),
       (68, '{\"step\":1,\"page\":0,\"lastMessageId\":null,\"gender\":\"Женщина\"}', 882419417),
       (69,
        '{\"step\":2,\"page\":0,\"lastMessageId\":null,\"gender\":\"Женщина\",\"age\":\"17-18\",\"answerType\":\"Текст\"}',
        1023612844),
       (70,
        '{\"step\":2,\"page\":0,\"lastMessageId\":null,\"gender\":\"Женщина\",\"age\":\"19-20\",\"answerType\":\"Текст\"}',
        32283466),
       (71,
        '{\"step\":7,\"page\":0,\"lastMessageId\":null,\"gender\":\"Женщина\",\"age\":\"19-20\",\"answerType\":\"Текст\"}',
        132702810),
       (72,
        '{\"step\":2,\"page\":0,\"lastMessageId\":null,\"gender\":\"Женщина\",\"age\":\"17-18\",\"answerType\":\"Текст\"}',
        139439520),
       (73,
        '{\"step\":2,\"page\":0,\"lastMessageId\":3617,\"gender\":\"Женщина\",\"age\":\"17-18\",\"answerType\":\"Текст\"}',
        1288015),
       (74,
        '{\"step\":2,\"page\":0,\"lastMessageId\":null,\"gender\":\"Женщина\",\"age\":\"19-20\",\"answerType\":\"Текст\"}',
        253306431),
       (75,
        '{\"step\":2,\"page\":0,\"lastMessageId\":null,\"gender\":\"Женщина\",\"age\":\"17-18\",\"answerType\":\"Текст\"}',
        353411737),
       (76,
        '{\"step\":2,\"page\":0,\"lastMessageId\":4298,\"gender\":\"Мужчина\",\"age\":\"14-16\",\"answerType\":\"Текст\"}',
        888052511),
       (77,
        '{\"step\":2,\"page\":0,\"lastMessageId\":null,\"gender\":\"Женщина\",\"age\":\"17-18\",\"answerType\":\"Текст\"}',
        319281254),
       (78,
        '{\"step\":2,\"page\":0,\"lastMessageId\":null,\"gender\":\"Женщина\",\"age\":\"17-18\",\"answerType\":\"Текст\"}',
        21702363),
       (79, '{\"step\":7,\"page\":0,\"lastMessageId\":null,\"gender\":\"Мужчина\",\"age\":\"17-18\"}', 218660792),
       (80,
        '{\"step\":2,\"page\":0,\"lastMessageId\":null,\"gender\":\"Женщина\",\"age\":\"19-20\",\"answerType\":\"Текст\"}',
        639336999),
       (81, '{\"step\":7,\"page\":0,\"lastMessageId\":null,\"gender\":\"Женщина\",\"age\":\"17-18\"}', 748553015),
       (82,
        '{\"step\":2,\"page\":0,\"lastMessageId\":null,\"gender\":\"Женщина\",\"age\":\"17-18\",\"answerType\":\"Текст\"}',
        258507369),
       (83,
        '{\"step\":2,\"page\":0,\"lastMessageId\":null,\"gender\":\"Женщина\",\"age\":\"14-16\",\"answerType\":\"Текст\"}',
        160131650),
       (84,
        '{\"step\":2,\"page\":0,\"lastMessageId\":null,\"gender\":\"Женщина\",\"age\":\"14-16\",\"answerType\":\"Текст\"}',
        405457920),
       (85,
        '{\"step\":2,\"page\":0,\"lastMessageId\":3707,\"gender\":\"Женщина\",\"age\":\"19-20\",\"answerType\":\"Текст\"}',
        1894787),
       (86,
        '{\"step\":2,\"page\":0,\"lastMessageId\":null,\"gender\":\"Мужчина\",\"age\":\"17-18\",\"answerType\":\"Текст\"}',
        43995878),
       (87,
        '{\"step\":2,\"page\":0,\"lastMessageId\":null,\"gender\":\"Женщина\",\"age\":\"17-18\",\"answerType\":\"Текст\"}',
        718645667),
       (88,
        '{\"step\":2,\"page\":0,\"lastMessageId\":null,\"gender\":\"Женщина\",\"age\":\"14-16\",\"answerType\":\"Аудио\"}',
        661729161),
       (89, '{\"step\":0,\"page\":0,\"lastMessageId\":3730}', 630417926),
       (90, '{\"step\":0,\"page\":0,\"lastMessageId\":3734}', 894515104),
       (91, '{\"step\":7,\"page\":0,\"lastMessageId\":null,\"gender\":\"Мужчина\",\"age\":\"17-18\"}', 85676818),
       (92,
        '{\"step\":2,\"page\":0,\"lastMessageId\":null,\"gender\":\"Женщина\",\"age\":\"14-16\",\"answerType\":\"Текст\"}',
        886714083),
       (93,
        '{\"step\":2,\"page\":0,\"lastMessageId\":null,\"gender\":\"Женщина\",\"age\":\"19-20\",\"answerType\":\"Текст\"}',
        348823588),
       (94,
        '{\"step\":2,\"page\":0,\"lastMessageId\":null,\"gender\":\"Мужчина\",\"age\":\"17-18\",\"answerType\":\"Текст\"}',
        109590355),
       (95,
        '{\"step\":2,\"page\":0,\"lastMessageId\":3767,\"gender\":\"Мужчина\",\"age\":\"17-18\",\"answerType\":\"Текст\"}',
        677532864),
       (96,
        '{\"step\":2,\"page\":0,\"lastMessageId\":3775,\"gender\":\"Мужчина\",\"age\":\"14-16\",\"answerType\":\"Текст\"}',
        221883703),
       (97,
        '{\"step\":10,\"page\":0,\"lastMessageId\":3790,\"gender\":\"Женщина\",\"age\":\"19-20\",\"answerType\":\"Текст\"}',
        796198289),
       (98,
        '{\"step\":2,\"page\":0,\"lastMessageId\":null,\"gender\":\"Женщина\",\"age\":\"14-16\",\"answerType\":\"Текст\"}',
        1053225270),
       (99,
        '{\"step\":2,\"page\":0,\"lastMessageId\":null,\"gender\":\"Женщина\",\"age\":\"17-18\",\"answerType\":\"Текст\"}',
        202777260),
       (100,
        '{\"step\":6,\"page\":0,\"lastMessageId\":4120,\"gender\":\"Женщина\",\"age\":\"19-20\",\"answerType\":\"Текст\"}',
        906772300),
       (101,
        '{\"step\":2,\"page\":0,\"lastMessageId\":3839,\"gender\":\"Женщина\",\"age\":\"14-16\",\"answerType\":\"Текст\"}',
        523938697),
       (102, '{\"step\":\"main_page\",\"page\":0,\"lastMessageId\":3846}', 682136636),
       (103, '{\"step\":\"main_page\",\"page\":0,\"lastMessageId\":null}', 1104279932),
       (104,
        '{\"step\":10,\"page\":0,\"lastMessageId\":3853,\"gender\":\"Женщина\",\"age\":\"19-20\",\"answerType\":\"Аудио\"}',
        83059301),
       (105,
        '{\"step\":2,\"page\":0,\"lastMessageId\":null,\"gender\":\"Мужчина\",\"age\":\"17-18\",\"answerType\":\"Текст\"}',
        221050943),
       (106,
        '{\"step\":2,\"page\":0,\"lastMessageId\":null,\"gender\":\"Женщина\",\"age\":\"14-16\",\"answerType\":\"Текст\"}',
        3548154),
       (107,
        '{\"step\":2,\"page\":0,\"lastMessageId\":3992,\"gender\":\"Мужчина\",\"age\":\"19-20\",\"answerType\":\"Текст\"}',
        213370688),
       (108,
        '{\"step\":2,\"page\":0,\"lastMessageId\":null,\"gender\":\"Женщина\",\"age\":\"14-16\",\"answerType\":\"Текст\"}',
        82776360),
       (109,
        '{\"step\":2,\"page\":0,\"lastMessageId\":4093,\"gender\":\"Мужчина\",\"age\":\"17-18\",\"answerType\":\"Текст\"}',
        754535203),
       (110,
        '{\"step\":2,\"page\":0,\"lastMessageId\":null,\"gender\":\"Женщина\",\"age\":\"14-16\",\"answerType\":\"Текст\"}',
        803265322),
       (111,
        '{\"step\":2,\"page\":0,\"lastMessageId\":null,\"gender\":\"Мужчина\",\"age\":\"17-18\",\"answerType\":\"Текст\"}',
        820362199),
       (112,
        '{\"step\":2,\"page\":0,\"lastMessageId\":3927,\"gender\":\"Женщина\",\"age\":\"19-20\",\"answerType\":\"Текст\"}',
        1646319),
       (113,
        '{\"step\":2,\"page\":0,\"lastMessageId\":3965,\"gender\":\"Мужчина\",\"age\":\"19-20\",\"answerType\":\"Текст\"}',
        273238472),
       (114,
        '{\"step\":2,\"page\":0,\"lastMessageId\":null,\"gender\":\"Женщина\",\"age\":\"19-20\",\"answerType\":\"Текст\"}',
        834721714),
       (115,
        '{\"step\":10,\"page\":0,\"lastMessageId\":3958,\"gender\":\"Мужчина\",\"age\":\"17-18\",\"answerType\":\"Текст\"}',
        915780519),
       (116,
        '{\"step\":2,\"page\":0,\"lastMessageId\":3974,\"gender\":\"Женщина\",\"age\":\"19-20\",\"answerType\":\"Текст\"}',
        750533376),
       (117,
        '{\"step\":2,\"page\":0,\"lastMessageId\":null,\"gender\":\"Мужчина\",\"age\":\"17-18\",\"answerType\":\"Текст\"}',
        825346586),
       (118,
        '{\"step\":2,\"page\":0,\"lastMessageId\":4005,\"gender\":\"Мужчина\",\"age\":\"19-20\",\"answerType\":\"Текст\"}',
        143762761),
       (119, '{\"step\":\"main_page\",\"page\":0,\"lastMessageId\":4106}', 1023818010),
       (120, '{\"step\":7,\"page\":0,\"lastMessageId\":4014,\"gender\":\"Мужчина\",\"age\":\"19-20\"}', 379398449),
       (121,
        '{\"step\":7,\"page\":0,\"lastMessageId\":null,\"gender\":\"Женщина\",\"age\":\"19-20\",\"answerType\":\"Текст\"}',
        744650771),
       (122,
        '{\"step\":2,\"page\":0,\"lastMessageId\":4033,\"gender\":\"Женщина\",\"age\":\"19-20\",\"answerType\":\"Текст\"}',
        892609057),
       (123,
        '{\"step\":2,\"page\":0,\"lastMessageId\":null,\"gender\":\"Женщина\",\"age\":\"19-20\",\"answerType\":\"Текст\"}',
        870262047),
       (124,
        '{\"step\":2,\"page\":0,\"lastMessageId\":4071,\"gender\":\"Женщина\",\"age\":\"14-16\",\"answerType\":\"Текст\"}',
        976560641),
       (125,
        '{\"step\":2,\"page\":0,\"lastMessageId\":null,\"gender\":\"Мужчина\",\"age\":\"19-20\",\"answerType\":\"Текст\"}',
        432772129),
       (126,
        '{\"step\":2,\"page\":0,\"lastMessageId\":4078,\"gender\":\"Мужчина\",\"age\":\"19-20\",\"answerType\":\"Текст\"}',
        85146236),
       (127,
        '{\"step\":2,\"page\":0,\"lastMessageId\":4083,\"gender\":\"Женщина\",\"age\":\"14-16\",\"answerType\":\"Текст\"}',
        985095455),
       (128,
        '{\"step\":2,\"page\":0,\"lastMessageId\":null,\"gender\":\"Женщина\",\"age\":\"14-16\",\"answerType\":\"Текст\"}',
        571025469),
       (129,
        '{\"step\":2,\"page\":0,\"lastMessageId\":4116,\"gender\":\"Женщина\",\"age\":\"19-20\",\"answerType\":\"Текст\"}',
        804581775),
       (130,
        '{\"step\":6,\"page\":0,\"lastMessageId\":null,\"gender\":\"Женщина\",\"age\":\"17-18\",\"answerType\":\"Текст\"}',
        302494104),
       (131,
        '{\"step\":2,\"page\":0,\"lastMessageId\":null,\"gender\":\"Женщина\",\"age\":\"14-16\",\"answerType\":\"Текст\"}',
        753980760),
       (132,
        '{\"step\":2,\"page\":0,\"lastMessageId\":4155,\"gender\":\"Мужчина\",\"age\":\"14-16\",\"answerType\":\"Текст\"}',
        787544415),
       (133, '{\"step\":0,\"page\":0,\"lastMessageId\":4147}', 266896383),
       (134,
        '{\"step\":2,\"page\":0,\"lastMessageId\":null,\"gender\":\"Мужчина\",\"age\":\"14-16\",\"answerType\":\"Аудио\"}',
        531278432),
       (135,
        '{\"step\":2,\"page\":0,\"lastMessageId\":null,\"gender\":\"Женщина\",\"age\":\"17-18\",\"answerType\":\"Текст\"}',
        177080787),
       (136,
        '{\"step\":2,\"page\":0,\"lastMessageId\":null,\"gender\":\"Женщина\",\"age\":\"14-16\",\"answerType\":\"Текст\"}',
        3205563),
       (137,
        '{\"step\":2,\"page\":0,\"lastMessageId\":null,\"gender\":\"Женщина\",\"age\":\"14-16\",\"answerType\":\"Текст\"}',
        168343734),
       (138,
        '{\"step\":2,\"page\":0,\"lastMessageId\":4250,\"gender\":\"Мужчина\",\"age\":\"14-16\",\"answerType\":\"Текст\"}',
        336258484),
       (139,
        '{\"step\":2,\"page\":0,\"lastMessageId\":null,\"gender\":\"Женщина\",\"age\":\"17-18\",\"answerType\":\"Текст\"}',
        621708244),
       (140,
        '{\"step\":2,\"page\":0,\"lastMessageId\":null,\"gender\":\"Женщина\",\"age\":\"14-16\",\"answerType\":\"Аудио\"}',
        509750605),
       (141,
        '{\"step\":2,\"page\":0,\"lastMessageId\":4189,\"gender\":\"Женщина\",\"age\":\"17-18\",\"answerType\":\"Текст\"}',
        1005326986),
       (142,
        '{\"step\":2,\"page\":0,\"lastMessageId\":4196,\"gender\":\"Женщина\",\"age\":\"14-16\",\"answerType\":\"Аудио\"}',
        436927483),
       (143, '{\"step\":7,\"page\":0,\"lastMessageId\":null,\"gender\":\"Женщина\",\"age\":\"17-18\"}', 603830196),
       (144,
        '{\"step\":2,\"page\":0,\"lastMessageId\":null,\"gender\":\"Мужчина\",\"age\":\"14-16\",\"answerType\":\"Текст\"}',
        257871955),
       (145, '{\"step\":1,\"page\":0,\"lastMessageId\":null,\"gender\":\"Женщина\"}', 529357252),
       (146,
        '{\"step\":2,\"page\":0,\"lastMessageId\":null,\"gender\":\"Женщина\",\"age\":\"14-16\",\"answerType\":\"Текст\"}',
        86199463),
       (147,
        '{\"step\":2,\"page\":0,\"lastMessageId\":null,\"gender\":\"Женщина\",\"age\":\"14-16\",\"answerType\":\"Текст\"}',
        84031013),
       (148, '{\"step\":7,\"page\":0,\"lastMessageId\":null,\"gender\":\"Женщина\",\"age\":\"17-18\"}', 623995186),
       (149,
        '{\"step\":2,\"page\":0,\"lastMessageId\":null,\"gender\":\"Женщина\",\"age\":\"14-16\",\"answerType\":\"Текст\"}',
        970529050),
       (150,
        '{\"step\":2,\"page\":0,\"lastMessageId\":null,\"gender\":\"Женщина\",\"age\":\"14-16\",\"answerType\":\"Текст\"}',
        376593708),
       (151, '{\"step\":0,\"page\":0,\"lastMessageId\":4234}', 134140053),
       (152,
        '{\"step\":2,\"page\":0,\"lastMessageId\":4286,\"gender\":\"Женщина\",\"age\":\"19-20\",\"answerType\":\"Текст\"}',
        326617524),
       (153,
        '{\"step\":2,\"page\":0,\"lastMessageId\":null,\"gender\":\"Женщина\",\"age\":\"19-20\",\"answerType\":\"Текст\"}',
        376836793),
       (154,
        '{\"step\":2,\"page\":0,\"lastMessageId\":4260,\"gender\":\"Мужчина\",\"age\":\"19-20\",\"answerType\":\"Текст\"}',
        358924887),
       (155,
        '{\"step\":2,\"page\":0,\"lastMessageId\":4292,\"gender\":\"Мужчина\",\"age\":\"14-16\",\"answerType\":\"Текст\"}',
        652661725),
       (156,
        '{\"step\":2,\"page\":0,\"lastMessageId\":null,\"gender\":\"Мужчина\",\"age\":\"14-16\",\"answerType\":\"Аудио\"}',
        703140825),
       (157,
        '{\"step\":2,\"page\":0,\"lastMessageId\":null,\"gender\":\"Женщина\",\"age\":\"14-16\",\"answerType\":\"Текст\"}',
        805052320),
       (158,
        '{\"step\":2,\"page\":0,\"lastMessageId\":null,\"gender\":\"Женщина\",\"age\":\"14-16\",\"answerType\":\"Текст\"}',
        56260825),
       (159,
        '{\"step\":6,\"page\":0,\"lastMessageId\":4559,\"gender\":\"Женщина\",\"age\":\"14-16\",\"answerType\":\"Текст\"}',
        555180260),
       (160,
        '{\"step\":2,\"page\":0,\"lastMessageId\":null,\"gender\":\"Мужчина\",\"age\":\"14-16\",\"answerType\":\"Текст\"}',
        571051493),
       (161,
        '{\"step\":2,\"page\":0,\"lastMessageId\":4385,\"gender\":\"Женщина\",\"age\":\"17-18\",\"answerType\":\"Текст\"}',
        963902694),
       (162,
        '{\"step\":2,\"page\":0,\"lastMessageId\":null,\"gender\":\"Женщина\",\"age\":\"14-16\",\"answerType\":\"Текст\"}',
        784497722),
       (163,
        '{\"step\":2,\"page\":0,\"lastMessageId\":4344,\"gender\":\"Мужчина\",\"age\":\"17-18\",\"answerType\":\"Аудио\"}',
        691982895),
       (164,
        '{\"step\":2,\"page\":0,\"lastMessageId\":4349,\"gender\":\"Мужчина\",\"age\":\"17-18\",\"answerType\":\"Аудио\"}',
        317078891),
       (165,
        '{\"step\":2,\"page\":0,\"lastMessageId\":null,\"gender\":\"Женщина\",\"age\":\"14-16\",\"answerType\":\"Текст\"}',
        878861959),
       (166,
        '{\"step\":6,\"page\":0,\"lastMessageId\":4538,\"gender\":\"Мужчина\",\"age\":\"14-16\",\"answerType\":\"Текст\"}',
        572122329),
       (167,
        '{\"step\":2,\"page\":0,\"lastMessageId\":4373,\"gender\":\"Женщина\",\"age\":\"14-16\",\"answerType\":\"Текст\"}',
        42055392),
       (168,
        '{\"step\":2,\"page\":0,\"lastMessageId\":null,\"gender\":\"Женщина\",\"age\":\"19-20\",\"answerType\":\"Текст\"}',
        49688803),
       (169, '{\"step\":0,\"page\":0,\"lastMessageId\":4392}', 248492057),
       (170,
        '{\"step\":2,\"page\":0,\"lastMessageId\":4399,\"gender\":\"Женщина\",\"age\":\"17-18\",\"answerType\":\"Текст\"}',
        595780454),
       (171,
        '{\"step\":2,\"page\":0,\"lastMessageId\":null,\"gender\":\"Женщина\",\"age\":\"19-20\",\"answerType\":\"Текст\"}',
        293457996),
       (172,
        '{\"step\":2,\"page\":0,\"lastMessageId\":null,\"gender\":\"Женщина\",\"age\":\"14-16\",\"answerType\":\"Текст\"}',
        422486849),
       (173,
        '{\"step\":2,\"page\":0,\"lastMessageId\":null,\"gender\":\"Мужчина\",\"age\":\"17-18\",\"answerType\":\"Текст\"}',
        737213494),
       (174,
        '{\"step\":2,\"page\":0,\"lastMessageId\":4454,\"gender\":\"Женщина\",\"age\":\"17-18\",\"answerType\":\"Аудио\"}',
        765847414),
       (175,
        '{\"step\":6,\"page\":0,\"lastMessageId\":null,\"gender\":\"Мужчина\",\"age\":\"19-20\",\"answerType\":\"Текст\"}',
        747523049),
       (176,
        '{\"step\":2,\"page\":0,\"lastMessageId\":4478,\"gender\":\"Женщина\",\"age\":\"17-18\",\"answerType\":\"Текст\"}',
        1004151361),
       (177,
        '{\"step\":2,\"page\":0,\"lastMessageId\":4485,\"gender\":\"Женщина\",\"age\":\"14-16\",\"answerType\":\"Текст\"}',
        174663798),
       (178, '{\"step\":0,\"page\":0,\"lastMessageId\":4487}', 381924513),
       (179,
        '{\"step\":2,\"page\":0,\"lastMessageId\":null,\"gender\":\"Женщина\",\"age\":\"14-16\",\"answerType\":\"Текст\"}',
        600927662),
       (180, '{\"step\":0,\"page\":0,\"lastMessageId\":4509}', 585978883),
       (181,
        '{\"step\":2,\"page\":0,\"lastMessageId\":null,\"gender\":\"Женщина\",\"age\":\"17-18\",\"answerType\":\"Аудио\"}',
        177340507),
       (182,
        '{\"step\":2,\"page\":0,\"lastMessageId\":null,\"gender\":\"Женщина\",\"age\":\"19-20\",\"answerType\":\"Текст\"}',
        860122387),
       (183, '{\"step\":0,\"page\":0,\"lastMessageId\":4530}', 678970450),
       (184,
        '{\"step\":6,\"page\":0,\"lastMessageId\":4536,\"gender\":\"Женщина\",\"age\":\"17-18\",\"answerType\":\"Текст\"}',
        3564230),
       (185,
        '{\"step\":2,\"page\":0,\"lastMessageId\":null,\"gender\":\"Женщина\",\"age\":\"19-20\",\"answerType\":\"Текст\"}',
        103042358),
       (186,
        '{\"step\":6,\"page\":0,\"lastMessageId\":4550,\"gender\":\"Женщина\",\"age\":\"19-20\",\"answerType\":\"Текст\"}',
        1155437332),
       (187,
        '{\"step\":6,\"page\":0,\"lastMessageId\":4555,\"gender\":\"Женщина\",\"age\":\"14-16\",\"answerType\":\"Текст\"}',
        522673022),
       (188, '{\"step\":0,\"page\":0,\"lastMessageId\":4557}', 1020161811);

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `admins`
--
ALTER TABLE `admins`
    ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `questions`
--
ALTER TABLE `questions`
    ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `users`
--
ALTER TABLE `users`
    ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `admins`
--
ALTER TABLE `admins`
    MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,
    AUTO_INCREMENT = 9;

--
-- AUTO_INCREMENT для таблицы `questions`
--
ALTER TABLE `questions`
    MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,
    AUTO_INCREMENT = 251;

--
-- AUTO_INCREMENT для таблицы `users`
--
ALTER TABLE `users`
    MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,
    AUTO_INCREMENT = 189;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT = @OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS = @OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION = @OLD_COLLATION_CONNECTION */;
