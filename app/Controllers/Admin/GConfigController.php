<?php

namespace App\Controllers\Admin;

use App\Controllers\AdminController;
use App\Services\Auth;
use App\Models\GConfig;

class GConfigController extends AdminController
{
    public function update($request, $response, $args)
    {
        $key  = trim($args['key']);
        $user = Auth::getUser();

        $config                 = GConfig::find($key);
        $config->oldvalue       = $config->value;
        $config->value          = $request->getParam('value');
        $config->operator_id    = $user->id;
        $config->operator_name  = $user->user_name;
        $config->operator_email = $user->email;
        $config->last_update    = time();
        if (!$config->save()) {
            $rs['ret'] = 0;
            $rs['msg'] = '修改失败';
            return $response->write(json_encode($rs));
        }
        $rs['ret'] = 1;
        $rs['msg'] = '修改成功';
        return $response->write(json_encode($rs));
    }

    public function telegram($request, $response, $args)
    {
        $table_config['total_column'] = array(
            'op'             => '操作',
            'name'           => '配置名称',
            'key'            => '配置名',
            'value'          => '配置值',
            'operator_id'    => '操作员 ID',
            'operator_name'  => '操作员名称',
            'operator_email' => '操作员邮箱',
            'last_update'    => '修改时间'
        );
        $table_config['default_show_column'] = array();
        foreach ($table_config['total_column'] as $column => $value) {
            $table_config['default_show_column'][] = $column;
        }
        $table_config['ajax_url'] = 'telegram/ajax';
        return $this->view()->assign('table_config', $table_config)->fetch('admin/config/telegram/index.tpl');
    }

    public function telegram_edit($request, $response, $args)
    {
        $key = trim($args['key']);
        $config = GConfig::find($key);
        return $this->view()->assign('edit_config', $config)->fetch('admin/config/telegram/edit.tpl');
    }

    public function telegram_update($request, $response, $args)
    {
        return self::update($request, $response, $args);
    }

    public function telegram_ajax($request, $response, $args)
    {
        $start = $request->getParam("start");
        $limit_length = $request->getParam('length');
        $configs = GConfig::skip($start)->where('key', 'LIKE', "%Telegram%")->limit($limit_length)->get();
        $total_conut = GConfig::where('key', 'LIKE', "%Telegram%")->count();
        $data = [];
        foreach ($configs as $config) {
            $tempdata = [];
            $tempdata['op']             = '<a class="btn btn-brand" href="/admin/config/telegram/' . $config->key . '/edit">编辑</a>';
            $tempdata['name']           = $config->name;
            $tempdata['key']            = $config->key;
            $tempdata['value']          = $config->value;
            $tempdata['operator_id']    = $config->operator_id;
            $tempdata['operator_name']  = $config->operator_name;
            $tempdata['operator_email'] = $config->operator_email;
            $tempdata['last_update']    = date('Y-m-d H:i:s', $config->last_update);
            if (strpos($config->key, '.enable.')) {
                switch ((int) $config->value) {
                    case 0:
                        $tempdata['value'] = '关闭';
                        break;
                    case 1:
                        $tempdata['value'] = '开启';
                        break;
                    default:
                        $tempdata['value'] = '未知';
                        break;
                }
            } else {
                $tempdata['value'] = '(请在编辑页面查看)';
            }
            $data[] = $tempdata;
        }
        $info = [
            'draw' => $request->getParam('draw'),
            'recordsTotal' => $total_conut,
            'recordsFiltered' => $total_conut,
            'data' => $data
        ];

        return json_encode($info, true);
    }
}
