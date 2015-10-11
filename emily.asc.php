<?php

$asc = glob('*.asc'); $asc = $asc[0];

date_default_timezone_set('GMT');

$etag = md5_file($asc);

if (isset($_SERVER['HTTP_IF_NONE_MATCH']) && $_SERVER['HTTP_IF_NONE_MATCH'] === $etag)
{
    header('HTTP/1.1 304 Not Modified');
    exit;
}

$content = file_get_contents($asc);

if (strpos($_SERVER['HTTP_ACCEPT_ENCODING'], 'gzip') !== false)
{
    header('Content-Encoding: gzip');
    $content = gzencode($content);
}

header('Content-Length: ' . strlen($content));

$date = new DateTime();
$date->add(new DateInterval('P10Y'));

header('Content-Type: text/plain');
header('Content-Disposition: inline; filename="Emily-Shepherd.asc"');
header('Etag: ' . $etag);
header('Expires: ' . $date->format('D, j M Y H:i:s e'));
header('Cache-Control: max-age=315360000');

echo $content;
flush();