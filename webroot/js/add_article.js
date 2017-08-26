

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
				
				$.each($("#upload_img_list #img_content img"), function(k,v){
					if (res.result.urls[k].url.indexOf($(this).attr("id")) != -1) {
						$(this).attr("src", res.result.urls[k].url)
					}
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
					var option = "<option value="+v.type+">"+v.title+"</option>"
					$("#article_category select").append(option)
				})
			},  
			error:function() {  
				alert("异常！");  
			}  
		});

	// 提交修改
	$('#submit_btn').on('click', function(){

        var imgs = []
        $.each($("#upload_img_list #img_content img"), function(k,v){
            if($(this).attr("src").indexOf("thumbnail") == -1) {
                alert("请先上传图片")
                return false
            }
            imgs[k] = $(this).attr("src")
        })
		var datas = $('#add_article_form').serializeArray()
		var isNull = false
		$.each(datas, function(k,v){
			if(!v.value) {
				alert(v.name + "不能为空")
				isNull = true
			}
		})
		datas.push({"name" : "thumbnails", "value" : imgs})
        if (isNull) return
            
		console.log(JSON.stringify(datas))
	
		$.ajax( {  
			url:'/article/add',
			data:JSON.stringify(datas),  
			type:'post',  
			dataType:'json',  
			success:function(data) {
				if (data.result == 'success') {
					alert('添加成功')
					ue.setContent('请输入文章内容')
					$("#article_title input").val("")
					$("#article_source input").val("")
					$("#article_category select option").eq(0).attr('selected', 'true');
				} else {
					alert('添加失败')
				}
			},  
			error:function() {  
				alert("异常！");  
			}  
		});
	})
})