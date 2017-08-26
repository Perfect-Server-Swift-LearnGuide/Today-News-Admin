$(function(){

    // 总页数
    var page = Math.ceil(parseInt($("#article_total").attr("value")) / 6)

    // 初始化分页插件
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

    // 获取分页数据
	function getData(page) {
		$.ajax( {  
			url:'/article/look',
			data:{"page" : page},  
			type:'get',  
			dataType:'json',  
			success:function(data) {
				var res = data.result
				$(".content_tr").remove()
				$.each(res, function(k,v){
					var html = '<tr class="content_tr">' + 
					'<td><div style="font-size:12px;">'+v.createtime+'</div></td>' +
					'<td><div>'+v.title+'</div></td>' +
					'<td><div>'+v.content+'</div></td>' +
					'<td><div>'+v.category+'</div></td>' +
					'<td><span style="font-size:14px;" id="look" jump="/article/detail/'+v.id+'">查看</span>&nbsp;&nbsp' +
					'<span style="font-size:14px;" id="edit" jump="/article/edit/'+v.id+'">编辑</span></td>' +
					'</tr>'
					
					$("#look_container table").append(html)
				})
				$.each($("#look_container tr:gt(0) td:nth-child(3) div"), function(){
					$(this).html($(this).text())
				})
				// 查看
				$("#look_container #look").on('click', function(){
					$("#index_content").load($(this).attr('jump'));
				})
				// 编辑
				$("#look_container #edit").on('click', function(){
					$("#index_content").load($(this).attr('jump'));
				})
			},  
			error:function() {  
				alert("异常！");  
			}  
		});
	}
	$.each($("#look_container tr:gt(0) td:nth-child(3) div"), function(){
		$(this).html($(this).text())
	})

})