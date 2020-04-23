#This script uses tonight's schedule batch csv file and send a table formatted in the email body 

#target folder
$path=""
#setting the location of the path
Set-Location $path;

#Calling the csv file from the folder
$csvs = Get-ChildItem .\<#enter the file name, for example 'list.csv'#>


#Sets the table in HTML by using css file 

$a = "<style>"
$a = $a + "BODY{background-color:white;}"
$a = $a + "table {font-family: verdana, arial, sans-serif;font-size: 11px;color: #333333;border-width: 1px;border-color: #3A3A3A;border-collapse: collapse;}"
$a = $a + "th {border-width: 1px;padding: 8px;border-style: solid;border-color: #FFA6A6;background-color: #D56A6A;color: #ffffff;}"
$a = $a + "tr:hover td {cursor: pointer;}"
$a = $a + "tr:nth-child(even) td{background-color: #F7CFCF;}"
$a = $a + "td{border-width: 1px;padding: 8px;border-style: solid;border-color: #FFA6A6;background-color: #ffffff;}"
$a = $a + "</style>"



#Count of the row in the file
$lines = Get-Content $csvs
$y = "$($lines.Count)"


#Add body information
$bodyinfo = <#<H2>Include body information you want to send along with report in the email</H2>#> + <#This will count the rows in the file and send along in the email. Telling user how many rows are in the report#>"<p>Total rows in the file: $y</p>"

#Use Import-csv function to read the csv file and tell the header name you want to select. Using ConvertTo-Html function, it will convert to HTML table with using css Style
$csv = Import-Csv $csvs | Select-Object "Schedule Name","Job Name","Task Name","Filepath","FileName" | ConvertTo-Html -Head $a -Body $bodyinfo 

#Enter the email parameters here
$emailSMTPServer = ""
$emailRecipients ="" 
$emailFrom = ""
$emailSubject = " "
$emailBody = "$csv" 

#Add the email patameter to send-mailmessage
Send-MailMessage -From $emailFrom -To $emailRecipients  -SmtpServer $emailSMTPServer -subject $emailSubject -Body $emailBody -BodyAsHtml
#Sends the actual email 

