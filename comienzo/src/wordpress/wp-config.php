<?php
define('DB_NAME', getenv('WORDPRESS_DB_NAME'));
define('DB_USER', getenv('WORDPRESS_DB_USER'));
define('DB_PASSWORD', getenv('WORDPRESS_DB_PASSWORD'));
define('DB_HOST', getenv('WORDPRESS_DB_HOST'));

define('DB_CHARSET', 'utf8');
define('DB_COLLATE', '');

define('AUTH_KEY',         '{=I)<H%TUl~p>B%^`y94)t`f^AM`afx7u=_mz}mK}peU++G{]q}j$xpUfT:.YS}A');
define('SECURE_AUTH_KEY',  '1)Sc^A>Qnp|%ktm`2NTp!SRUQpA118xL/m&G9oKP;fCpEym6<2Yno|Cxn:pj{,3&');
define('LOGGED_IN_KEY',    'RasU,/N|RZ?k?]zx>v ^,:o3-I+d`S0J~x[0n?.2XAP.b@^Y6!N|H<~q,m`Z<vUo');
define('NONCE_KEY',        'ft@C86Jb[`gyFUxk2+XC+8c+&mu.3ht9@zstR^d=6jZb(O$&ZWEF9m)%.mO::PTt');
define('AUTH_SALT',        '3`A*)O+k&NO11Okv%+|?-st.ofUOM.n/y?d>lfj-v-6<i,*)6L/+hpl4?x zQoRW');
define('SECURE_AUTH_SALT', '?*G>:v|AR9*zcM<x7S>*iQ l@TilZcK4R?P|@uy~fDh8KrWk,)/jqk;Ktd<;Px L');
define('LOGGED_IN_SALT',   'nRAwlCT.mNCPwTQp+,Kw_ +d`vL*fk MqSe`6Q-rYP3uS3zb-+fW7S[%-87^#/Gw');
define('NONCE_SALT',       's9XEi|t8=luHtc8a 5fli78/g8w>sSwVy,Ayhyj=[fYr]0VYB~3. <$xw4kiO~.$');

$table_prefix = 'wp_';

define('WP_DEBUG', false);

if (!defined('ABSPATH')) {
    define('ABSPATH', __DIR__ . '/');
}

require_once ABSPATH . 'wp-settings.php';
