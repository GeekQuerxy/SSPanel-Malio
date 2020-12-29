<?php

namespace App\Controllers;

use App\Models\User;
use App\Services\View;
use App\Services\Auth;
use Slim\Http\Response;
use Psr\Http\Message\ResponseInterface;
use Smarty;
use App\Services\Internationalization;

/**
 * BaseController
 */
class BaseController
{
    /**
     * @var Smarty
     */
    protected $view;

    /**
     * @var User
     */
    protected $user;

    /**
     * Construct page renderer
     */
    public function __construct()
    {
        $this->view = View::getSmarty();
        $this->user = Auth::getUser();
        $this->i18n = new Internationalization();
    }

    /**
     * Get smarty
     *
     * @return Smarty
     */
    public function view()
    {
        return $this->view;
    }

    // TODO: remove
    /**
     * Output JSON
     *
     * @param Response      $response
     * @param array|object  $resource
     *
     * @return ResponseInterface
     */
    public function echoJson(Response $response, $resource)
    {
        return $response->withJson($resource);
    }
}
