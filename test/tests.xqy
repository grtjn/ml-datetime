xquery version "1.0-ml";

module namespace test = "http://github.com/robwhitby/xray/test";
import module namespace assert = "http://github.com/robwhitby/xray/assertions" at "../xray/src/assertions.xqy";

import module namespace datetime = "http://marklogic.com/datetime" at "../datetime.xqy";

declare namespace html = "http://www.w3.org/1999/xhtml";

declare default function namespace "http://www.w3.org/2005/xpath-functions";

declare option xdmp:mapping "false"; (::)

declare %test:case function test:parse-date-fail()
{
  for $str in (
    element CreationDate { "1910/10/30 11:10:752" },
    element Creation_Date { "xxx" },
    element Creation_Date { "00:00" }
  )
  let $date := datetime:parse-date($str)
  return (
    assert:empty($date, $str)
  )
};

declare %test:case function test:parse-date-castable()
{
  for $str in (
    element date { "2001-04-26" },
    element dateZ { "2001-04-26Z" },
    element dateTZ { "2001-04-26+05:00" },
    element xmp_pdf_CreationDate { "2001-04-26T17:49:38Z" },
    element xmp_pdf_CreationDate { "2002-02-19T23:46:50Z" },
    element xmp_pdf_ModDate { "2001-04-26T13:12:40-05:00" },
    element xmp_pdf_ModDate { "2002-02-19T18:52:09-05:00" },
    element xmp_xap_CreateDate { "2001-04-26T17:49:38Z" },
    element xmp_xap_CreateDate { "2002-02-19T23:46:50Z" },
    element xmp_xap_MetadataDate { "2001-04-26T13:12:40-05:00" },
    element xmp_xap_MetadataDate { "2002-02-19T18:52:09-05:00" },
    element xmp_xap_ModifyDate { "2001-04-26T17:49:38Z" },
    element xmp_xap_ModifyDate { "2002-02-19T18:52:09-05:00" }
  )
  let $date := datetime:parse-date($str)
  return (
    assert:not-empty($date, $str)
  )
};

declare %test:case function test:parse-date-simple()
{
  for $str in (
    element CreationDate { "2000/02/10" },
    element CreationDate { "2000/03/21" },
    element CreationDate { "2001/05/10" },
    element CreationDate { "2001/05/18" },
    element CreationDate { "2013/05/27+02'00'" },
    element CreationDate { "2015/02/05 (UTC)" },
    element CreationDate { "2015/02/05 (GMT)" },
    element CreationDate { "2015/02/05 (BST)" },
    element CreationDate { "2015/02/05Z" },
    element CreationDate { "2015/08/03-05'00'" },
    element Date { "2000:09:13" },
    element Date { "2000:09:30" },
    element Date { "2001:10:14" },
    element Date { "2002:01:15" },
    element Date { "2002:03:23" },
    element ModDate { "2000/11/01-05'00'" },
    element ModDate { "2001/04/10" },
    element ModDate { "2001/05/23" },
    element ModDate { "2001/05/29+01'00'" },
    element ModDate { "2015/02/05 (CET)" },
    element ModDate { "2015/02/05 (CEST)" },
    element Original_Date_Time { "2002:03:23" }
  )
  let $date := datetime:parse-date($str)
  return (
    assert:not-empty($date, $str)
  )
};

declare %test:case function test:parse-date-complex()
{
  for $str in (
    element Converted_Date { "23-Sep-1999" },
    element CreationDate { "D:Fri Jul 05 2002" },
    element CreationDate { "Friday, January 28, 2000" },
    element Creation_Date { "Mon, 18 Dec 2000 (UTC)" },
    element Creation_Date { "Sun, 13 Sep 1999" },
    element Creation_Date { "Sun, 22 Feb 2000" },
    element Date { "6 Feb 2001 -0000" },
    element Date { "Fri, 27 Apr 2001 (UTC)" },
    element Date { "Fri, 6 Oct 2000 -0700" },
    element Date { "Mon, 24 Apr 2000 (CET)" },
    element Date { "Mon, 5 Mar 2001 -0800" },
    element Date { "Thu, 1 Mar 2001 -0700" },
    element Date { "Wed, 13 Dec 2000 -0800" },
    element Date { "Wed, 15 Nov 2000 -0800" },
    element Date { "Wed, 22 Mar 2000 (CEST)" },
    element Date_created { "Wed, 14 Mar 2001 (UTC)" },
    element Date_modified { "Wed, 26 Sep 2001 (UTC)"},
    element Last_Edited_Date { "Sun, 13 Sep 1999" },
    element Last_Edited_Date { "Sun, 22 Feb 2000" },
    element Last_Saved_Date { "Sat, 23 Dec 2000 (UTC)" },
    element Last_Saved_Date { "Thu, 31 Jan 2002 (UTC)" },
    element Sent_Date { "Fri, 27 Apr 2001" },
    element Sent_Date { "Mon, 24 Apr 2000" },
    element Sent_Date { "Wed, 22 Mar 2000" }
  )
  let $date := datetime:parse-date($str)
  return (
    assert:not-empty($date, $str)
  )
};

declare %test:case function test:parse-date-international()
{
  for $str in (
    element Date { attribute xml:lang { "nl" }, "vrijdag, 6 oktober 2000 -0700" },
    element Date { attribute xml:lang { "fr" }, "vendredi, 6 octobre 2000 -0700" }
  )
  let $date := datetime:parse-date($str, ($str/ancestor-or-self::*/@xml:lang)[1])
  return (
    assert:not-empty($date, $str)
  )
};

declare %test:case function test:parse-dateTime-fail()
{
  for $str in (
    element CreationDate { "1910/10/30 11:10:752" },
    element Creation_Date { "xxx" },
    element Creation_Date { "00:00" }
  )
  let $date := datetime:parse-dateTime($str)
  return (
    assert:empty($date, $str)
  )
};

declare %test:case function test:parse-dateTime-castable()
{
  for $str in (
    element date { "2001-04-26" },
    element dateZ { "2001-04-26Z" },
    element dateTZ { "2001-04-26+05:00" },
    element xmp_pdf_CreationDate { "2001-04-26T17:49:38Z" },
    element xmp_pdf_CreationDate { "2002-02-19T23:46:50Z" },
    element xmp_pdf_ModDate { "2001-04-26T13:12:40-05:00" },
    element xmp_pdf_ModDate { "2002-02-19T18:52:09-05:00" },
    element xmp_xap_CreateDate { "2001-04-26T17:49:38Z" },
    element xmp_xap_CreateDate { "2002-02-19T23:46:50Z" },
    element xmp_xap_MetadataDate { "2001-04-26T13:12:40-05:00" },
    element xmp_xap_MetadataDate { "2002-02-19T18:52:09-05:00" },
    element xmp_xap_ModifyDate { "2001-04-26T17:49:38Z" },
    element xmp_xap_ModifyDate { "2002-02-19T18:52:09-05:00" }
  )
  let $date := datetime:parse-dateTime($str)
  return (
    assert:not-empty($date, $str)
  )
};

declare %test:case function test:parse-dateTime-simple()
{
  for $str in (
    element CreationDate { "2000/02/10 18:18:52" },
    element CreationDate { "2000/03/21 15:40:04" },
    element CreationDate { "2001/05/10 08:26:43" },
    element CreationDate { "2001/05/18 14:12:15" },
    element CreationDate { "2013/05/27 17:09:27+02'00'" },
    element CreationDate { "2015/02/05 08:07:14 (UTC)" },
    element CreationDate { "2015/02/05 08:07:14 (GMT)" },
    element CreationDate { "2015/02/05 08:07:14 (BST)" },
    element CreationDate { "2015/02/05 08:07:14Z" },
    element CreationDate { "2015/08/03 14:25:36-05'00'" },
    element Date { "2000:09:13 13:05:25" },
    element Date { "2000:09:30 18:22:51" },
    element Date { "2001:10:14 14:47:40" },
    element Date { "2002:01:15 19:31:10" },
    element Date { "2002:03:23 15:18:44" },
    element ModDate { "2000/11/01 18:41:08-05'00'" },
    element ModDate { "2001/04/10 17:43:22" },
    element ModDate { "2001/05/23 10:39:00" },
    element ModDate { "2001/05/29 10:56:12+01'00'" },
    element ModDate { "2015/02/05 08:07:14 (CET)" },
    element ModDate { "2015/02/05 08:07:14 (CEST)" },
    element Original_Date_Time { "2002:03:23 15:18:44" }
  )
  let $date := datetime:parse-dateTime($str)
  return (
    assert:not-empty($date, $str)
  )
};

declare %test:case function test:parse-dateTime-complex()
{
  for $str in (
    element CreationDate { "D:Fri Jul 05 15:52:53 2002" },
    element CreationDate { "Friday, January 28, 2000 9:52:22 AM" },
    element Creation_Date { "Mon, 18 Dec 2000 9:53:00 PM (UTC)" },
    element Creation_Date { "Sun, 13 Sep 1999 4:46:00 PM" },
    element Creation_Date { "Sun, 22 Feb 2000 8:54:00 AM" },
    element Date { "6 Feb 2001 00:22:15 -0000" },
    element Date { "Fri, 27 Apr 2001 3:23:39 PM (UTC)" },
    element Date { "Fri, 6 Oct 2000 09:20:25 -0700" },
    element Date { "Mon, 24 Apr 2000 11:25:41 PM (CET)" },
    element Date { "Mon, 5 Mar 2001 12:42:29 -0800" },
    element Date { "Thu, 1 Mar 2001 09:13:00 -0700" },
    element Date { "Wed, 13 Dec 2000 15:55:35 -0800" },
    element Date { "Wed, 15 Nov 2000 18:12:53 -0800" },
    element Date { "Wed, 22 Mar 2000 8:46:52 PM (CEST)" },
    element Date_created { "Wed, 14 Mar 2001 10:26:00 PM (UTC)" },
    element Date_modified { "Wed, 26 Sep 2001 3:45:00 PM (UTC)"},
    element Last_Edited_Date { "Sun, 13 Sep 1999 4:46:00 PM" },
    element Last_Edited_Date { "Sun, 22 Feb 2000 8:54:00 AM" },
    element Last_Saved_Date { "Sat, 23 Dec 2000 1:33:00 AM (UTC)" },
    element Last_Saved_Date { "Thu, 31 Jan 2002 5:21:36 PM (UTC)" },
    element Sent_Date { "Fri, 27 Apr 2001 10:23:39 AM" },
    element Sent_Date { "Mon, 24 Apr 2000 6:25:41 PM" },
    element Sent_Date { "Wed, 22 Mar 2000 5:46:52 PM" }
  )
  let $date := datetime:parse-dateTime($str)
  return (
    assert:not-empty($date, $str)
  )
};

declare %test:case function test:parse-dateTime-international()
{
  for $str in (
    element Date { attribute xml:lang { "nl" }, "vrijdag, 6 oktober 2000 09:20:25 -0700" },
    element Date { attribute xml:lang { "fr" }, "vendredi, 6 octobre 2000 09:20:25 -0700" }
  )
  let $date := datetime:parse-dateTime($str, ($str/ancestor-or-self::*/@xml:lang)[1])
  return (
    assert:not-empty($date, $str)
  )
};

(: test helper functions :)

declare private variable $root := resolve-uri("..", xdmp:modules-root() || xdmp:get-request-path());

declare private function test:eval($query, $vars) {
  xdmp:eval(
    $query,
    $vars,
    <options xmlns="xdmp:eval">
      <isolation>different-transaction</isolation>
      <root>{$root}</root>
      </options>
  )
};