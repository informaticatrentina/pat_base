<?php
namespace IT\PATBase;

/**
 * Class ITClass
 *
 * Questa classe va estesa dalle classe che implementano i test unitari.
 * Le classi eZ vengono mockate aggiungendo il suffisso Test.
 *
 */
class ITClass
{
    const NON_TEST = 0x01;
    const TEST = 0x02;

    protected $env = self::NON_TEST;

    public function __constructor( $env = self::NON_TEST )
    {
        $this->env = $env;
    }

    /**
     * @param $class
     * @param $env
     * @return string
     */
    protected function checkEnv($class)
    {
        if ($this->env === self::TEST) {
            $class .= 'Test';
        }

        return $class;
    }

    /**
     * Chiamata di una API Rest
     *
     * @param $method
     * @param $url
     * @param bool $data
     * @param string $user
     * @param string $pass
     * @return mixed
     */
    protected function callAPI($method, $url, $data = false, $user = '', $pass = '')
    {
        $curl = curl_init();

        switch ($method) {
            case "POST":
                {
                    curl_setopt($curl, CURLOPT_POST, 1);

                    if ($data) {
//                        curl_setopt($curl, CURLOPT_CUSTOMREQUEST, "POST");
//                        curl_setopt($curl, CURLOPT_HTTPHEADER, array(
//                            'Content-Type: application/json',
//                            'Content-Length: ' . strlen($data))
//                        );

                        curl_setopt($curl, CURLOPT_POSTFIELDS, $data);
                    }
                    break;
                }
            case "PUT":
                {
                    //curl_setopt($curl, CURLOPT_PUT, 1);
                    curl_setopt($curl, CURLOPT_CUSTOMREQUEST, "PUT");
                    curl_setopt($curl, CURLOPT_HTTPHEADER, array('Content-Type: application/json'));

                    if($data){
                        curl_setopt($curl, CURLOPT_POSTFIELDS, $data);
                    }
                    break;
                }
            default:
                if ($data) {
                    $url = sprintf("%s?%s", $url, http_build_query($data));
                }
        }
        curl_setopt($curl, CURLOPT_URL, $url);
        curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);

        if(!empty($user)){
            curl_setopt($curl, CURLOPT_USERPWD, $user . ":" . $pass);
        }

        $result = curl_exec($curl);

        curl_close($curl);

        return json_decode($result);
    }

    /**
     * Esegue la redirect verso un url relativo
     *
     * @param String $to
     * @return boolean
     */
    public static function redirect($to)
    {

        $location = "Location: $to";

        if(!substr($to, 0, 4) === 'http'){
            $schema = $_SERVER['SERVER_PORT'] == '443' ? 'https' : 'http';
            $host = strlen($_SERVER['HTTP_HOST'])?$_SERVER['HTTP_HOST']:$_SERVER['SERVER_NAME'];

            $location = "Location: $schema://$host$to";
        }

        if (headers_sent()){
            return false;
        }
        else {
            //301 - Moved forever.
            header("HTTP/1.1 301 Moved Permanently");

            //302 - Use the same method (GET/POST) to request the specified page.
            //header("HTTP/1.1 302 Found");

            //303 - Use GET to request the specified page.
            // header("HTTP/1.1 303 See Other")

            header($location);

            \eZExecution::cleanExit();
        }
    }

}
