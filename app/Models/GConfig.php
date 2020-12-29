<?php

namespace App\Models;

use App\Services\DefaultConfig;

class GConfig extends Model
{

    /**
     * The connection name for the model.
     *
     * @var string
     */
    protected $connection = 'default';

    /**
     * The table associated with the model.
     *
     * @var string
     */
    protected $table = 'gconfig';

    /**
     * The primary key associated with the table.
     *
     * @var string
     */
    protected $primaryKey = 'key';

    /**
     * Indicates if the IDs are auto-incrementing.
     *
     * @var bool
     */
    public $incrementing = false;

    /**
     * The "type" of the auto-incrementing ID.
     *
     * @var string
     */
    protected $keyType = 'string';

    public static function recover($user)
    {
        $this->oldvalue       = $this->value;
        $this->value          = DefaultConfig::default_value($this->key)['value'];
        $this->operator_id    = $user->id;
        $this->operator_name  = ('[恢复默认] - ' . $user->user_name);
        $this->operator_email = $user->email;
        $this->last_update    = time();
        $this->save();
    }
}
