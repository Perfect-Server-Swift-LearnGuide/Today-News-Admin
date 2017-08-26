
var img_upload_formdata = new FormData();

// 添加图片
function add_imgs_action(e) {
    $("#upload_img").css("display", "none")
    $("#upload_img_list").css("display", "inline-block")

    if($("#upload_img_list #img_content").length > 8) {
        alert("最多选择9张图片")
        return false
    }

    var file = e.target.files[0];
    var reader = new FileReader();
    reader.onloadend = function () {
        // 图片的 base64 格式, 可以直接当成 img 的 src 属性值
        console.log("上传图片")
        var dataURL = reader.result;
        var blob = dataURItoBlob(dataURL);
        var date = new Date().Format("yyyy-MM-dd-hh-mm-ss");
        img_upload_formdata.append('article_thumbnail' + date, blob);
        var html = '<span style="width:96px;height:100px;margin:5px;position:relative;">' + 
        '<img style="width:100%;height:100%;position:absolute;" id="'+date+'" src="'+dataURL+'" />' + 
        '<p class="delete_img"></p>' +
        '</span>'

 

        $("#upload_img_list #img_content").append(html)
        $(".delete_img").on("click",function(){
            $(this).fadeOut(500,function(){
                $(this).parent().remove();
            })
        })
    }
    reader.readAsDataURL(file); // 读出 base64
}
$(function(){

    

    $(".delete_img").on("click",function(){
        $(this).fadeOut(500,function(){
            $(this).parent().remove();
        })
    })


    $("#upload_img").css("display", "none")
    $("#upload_img_list").css("display", "inline-block")

    // 上传图片
    $("#upload_img_action").on('click',function(){
        $.ajax({  
            url:'/article/upload',  
            type:'post',  
            dataType:'json',
            data:img_upload_formdata,
            cache:false,
            processData:false,
            contentType:false,
            success:function(res) {
                var images = []
                $.each($("#upload_img_list #img_content img"), function(k,v){
                    if ($(v).attr("src").indexOf("base64") != -1) {
                        images.push(v)   
                    }
                })

                $.each(images, function(k,v){
                    $(v).attr("src", res.result.urls[k].url)
                })

                alert("上传成功")
            },  
            error:function() {  
                alert("异常！");  
            }  
        });
    })
    // 请求分类
    $.ajax({  
        url:'/article/category',  
        type:'get',  
        dataType:'json',  
        success:function(res) {
            $.each(res.data,function(k,v){
                var def_select = parseInt($("#article_category select").attr("defselect"))
                var eq_select = (def_select == v.type)
                var option = '<option ' +(eq_select ? 'selected="selected"' : '')+ ' value="'+v.type+'">'+v.title+'</option>'
                $("#article_category select").append(option)
            })
        },  
        error:function() {  
            alert("异常！");  
        }  
    });

    // 提交保存
    $('#submit_btn').on('click', function(){
        var imgs = []
        $.each($("#upload_img_list #img_content img"), function(k,v){
            if($(this).attr("src").indexOf("thumbnail") == -1) {
                alert("请先上传图片")
                return false
            }
            imgs[k] = $(this).attr("src")
        })
        // var data = $('#add_article_form').serialize()
        var datas = $('#add_article_form').serializeArray()
        var isNull = false
        $.each(datas, function(k,v){
            if(!v.value) {
                alert(v.name + "不能为空")
                isNull = true
            }
        })
        if (imgs.length > 0) {
            datas.push({"name" : "thumbnails", "value" : imgs})
        } else {
            datas.push({"name" : "thumbnails", "value" : []})
        }

        console.log(datas)
        if (isNull) return
        $.ajax( {  
            url:'/article/edit',
            data:JSON.stringify(datas),  
            type:'post',  
            dataType:'json',  
            success:function(data) {
                if (data.result == 'success') {
                    alert('修改成功')
                } else {
                    alert('修改失败')
                }
            },  
            error:function() {  
                alert("异常！");  
            }  
        });
    })
})