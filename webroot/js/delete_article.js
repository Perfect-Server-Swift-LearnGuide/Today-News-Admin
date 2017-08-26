$(function(){

    // 总页数
	var page = Math.ceil(parseInt($("#article_total").attr("value")) / 6)
	laypage({
		cont: 'page', //容器。值支持id名、原生dom对象，jquery对象,
		pages: page, //总页数
		skip: false, //是否开启跳页
		skin: '#FFA000',
		groups: 5, //连续显示分页数
		first: '首页', //若不显示，设置false即可
		last: '尾页', //若不显示，设置false即可
		prev: '<', //若不显示，设置false即可
		next: '>', //若不显示，设置false即可
		hash: true, //开启hash
		jump: function(obj){ //触发分页后的回调
			getData(obj.curr)
		}
	})

	function getData(page) {
		$.ajax( {  
			url:'/article/look',
			data:{"page" : page},  
			type:'get',  
			dataType:'json',  
			success:function(data) {
				var res = data.result
				console.log( data)
				$(".content_tr").remove()
				$.each(res, function(k,v){
					var html = '<tr class="content_tr">' + 
					'<td><div><input class="delete_select" type="checkbox" delete='+v.id+'></input></div></td>' +
					'<td><div style="font-size:12px;">'+v.createtime+'</div></td>' +
					'<td><div>'+v.title+'</div></td>' +
					'<td><div>'+v.content+'</div></td>' +
					'<td><div>'+v.category+'</div></td>' +
					'<td><span style="font-size:14px;" id="look" jump="/article/detail/'+v.id+'">查看</span>' +
					'</tr>'
					$("#look_container table").append(html)
				})
				$.each($("#look_container tr:gt(0) td:nth-child(4) div"), function(){
					$(this).html($(this).text())
				})

				// 查看
				$("#look_container #look").on('click', function(){
					$("#index_content").load($(this).attr('jump'));
				})
			},  
			error:function() {  
				alert("异常！");  
			}  
		});
	}

	// 批量删除
	$("#delete_btn").on('click', function(){
		var datas = []
		$.each($('.delete_select:checked'),function(k,v){
			datas[k] = $(this).attr("delete")
		})
		console.log(datas)

		$.ajax( {  
			url:'/article/delete',
			data:{"deletes":datas},  
			type:'post',  
			dataType:'json',  
			success:function(data) {
				if (data.result == 'success') {
					alert('删除成功')
					$("#index_content").load("/article/delete");
				} else {
					alert('删除失败')
				}
			},  
			error:function() {  
				alert("异常！");  
			}  
		});
	})

	$.each($("#look_container tr:gt(0) td:nth-child(4) div"), function(){
		$(this).html($(this).text())
	})

	// 选中
	$("#all_delete_select").on('click',function(){
		$('.delete_select').prop('checked',$(this).prop('checked'));
	})

})