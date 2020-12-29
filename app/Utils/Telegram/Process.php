<?php

namespace App\Utils\Telegram;

use App\Models\User;
use App\Services\Config;
use Telegram\Bot\Api;
use Exception;

class Process
{
    public static function index()
    {
        try {
            $bot = new Api($_ENV['telegram_token']);
            $bot->addCommands(
                [
                    Commands\MyCommand::class,
                    Commands\HelpCommand::class,
                    Commands\InfoCommand::class,
                    Commands\MenuCommand::class,
                    Commands\PingCommand::class,
                    Commands\StartCommand::class,
                    Commands\UnbindCommand::class,
                    Commands\CheckinCommand::class,
                    Commands\SetuserCommand::class,
                ]
            );
            $update = $bot->commandsHandler(true);
            if ($update->getCallbackQuery() !== null) {
                Callbacks\Callback::CallbackQueryMethod($bot, $update->getCallbackQuery());
            }
            if ($update->getMessage() !== null) {
                Message::MessageMethod($bot, $update->getMessage());
            }
        } catch (Exception $e) {
            $e->getMessage();
        }
    }
}
