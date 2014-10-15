function youziku129() {
    var resultStr = $(".zhimang-xing").text();
    var md5 = "";
    resultStr = Trim(resultStr);
    resultStr = SelectWord(resultStr);
    md5 = $.md5("ea0ef7a336654c58a228c902c43dcad3"+"zhimang-xing" + resultStr);
    $.getJSON("http://www.youziku.com/webfont/CSSPOST?jsoncallback=?", { "id": md5, "guid": "ea0ef7a336654c58a228c902c43dcad3", "type": "5" }, function (json) {
        if (json.result == 0) {/*alert("需要生成");*/
            $.post("http://www.youziku.com/webfont/PostCorsCreateFont", { "name": "zhimang-xing", "gid": "ea0ef7a336654c58a228c902c43dcad3", "type": "5", "text": resultStr }, function (json) {
            if (json == "0") { /*alert("参数不对");*/
            } else if (json == "2") {/*alert("超过每日生成字体数的上限");*/
            } else if (json == "3") { /*alert("当前正在生成请稍后");*/
            } else {/*alert("正在生成");*/
            }
        });
        }
        else {/*alert("下载css文件");*/
            loadExtentFile("http://www.youziku.com/webfont/css?id=" + md5 + "&guid=" + "ea0ef7a336654c58a228c902c43dcad3" + "&type=5");
        }
    });
}
(function youziku() {
if (window.location.href.toString().substring(0, 7) == "file://") {
        alert("你当前是通过双击打开html文件，进行本地测试的，这样看不到字体效果，一定要通过本地建立的虚拟网站或发布到外网进行测试。详见有字库的使用说明。");
    }else{
    youziku129();
    }
})()