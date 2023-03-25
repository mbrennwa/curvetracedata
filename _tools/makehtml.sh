echo <!DOCTYPE html>
echo <html>
echo <head>
echo <style>
echo #data {
echo   font-family: Arial, Helvetica, sans-serif;
echo   border-collapse: collapse;
echo   width: 100%;
echo }
echo #data td, #data th {
echo   border: 1px solid #ddd;
echo   padding: 8px;
echo }
echo #data tr:nth-child(even){background-color: #f2f2f2;}
echo #data tr:hover {background-color: #ddd;}
echo #data th {
echo   padding-top: 12px;
echo   padding-bottom: 12px;
echo   text-align: left;
echo   background-color: #04AA6D;
echo   color: white;
echo }
echo </style>
echo </head>
echo <body>




echo "<table id="data">" ;
n=0
while read INPUT ; do
	if [ "$n" = "0" ]; then
		echo "<tr><th>${INPUT//,/</th><th>}</th></tr>" ;
	else
		echo "<tr><td>${INPUT//,/</td><td>}</td></tr>" ;
	fi
	n=$((n+1))
done < parameters.csv ;
echo "</table>"


