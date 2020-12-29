<?php

namespace App\Command;

use App\Models\User;
use App\Services\Config;
use Ramsey\Uuid\Uuid;

class Malio
{
    public static function GenerateUUIDforAllUsers()
    {
        $users = User::all();
        foreach ($users as $user) {
            if ($user->uuid == null) {
                $user->uuid = Uuid::uuid3(Uuid::NAMESPACE_DNS, ($user->passwd) . Config::get('key') . $user->id)->toString();
                if ($user->save()) {
                    echo ($user->id . " 生成UUID成功 " . $user->uuid . PHP_EOL);
                } else {
                    echo ($user->id . " 失败 " . $user->uuid . PHP_EOL);
                };
            }
        }
    }
}