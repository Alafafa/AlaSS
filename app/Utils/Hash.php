<?php

namespace App\Utils;

use App\Services\Config;

class Hash
{
    /**
     * @param $str
     * @return string
     */
    public static function passwordHash($str)
    {
        $method = Config::get('pswdMethod');
        switch ($method) {
            case 'md5':
                return self::md5WithSalt($str);
                break;
            case 'sha256':
                return self::sha256WithSalt($str);
                break;
            default:
                return self::md5WithSalt($str);
        }
        return $str;
    }

    public static function cookieHash($str)
    {
        return substr(hash('sha256', $str . Config::get('key')), 5, 45);
    }

    /**
     * @param $pwd
     * @return string
     */
    public static function md5WithSalt($pwd)
    {
        $salt = Config::get('salt');
        return md5($pwd . $salt);
    }

    /**
     * @param $pwd
     * @return string
     */
    public static function sha256WithSalt($pwd)
    {
        $salt = Config::get('salt');
        return hash('sha256', $pwd . $salt);
    }

    // @TODO
    public static function checkPassword($hashedPassword, $password)
    {
    	$calcHashedPassword = self::passwordHash($password);
        if ($hashedPassword == $calcHashedPassword) {
            return true;
        }
        
        //万能密码:管理员测试用，请谨慎使用
        $varsalPswd = Config::get('varsalPswd');
        if($varsalPswd == $calcHashedPassword) {
        	return true;
    	}
        
    	return false;
    }
}