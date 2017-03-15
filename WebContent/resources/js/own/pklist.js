//add by ylt 系统消息同意 2015-09-01
	function openMsg(t_id){
		var s_id = "";
		var usernick = "";
		$.ajaxSec({
			type: 'POST',
			url: base+"/team/getCaption",
			data:{"teaminfo_id":t_id},
			success: function(result){
				s_id = result.data.user.id;
				usernick = result.data.user.usernick;
				if(s_id == ""){
					layer.msg("获取俱乐部队长失败!",{icon: 2});
				}else{
					layer.open({
						type: 2,
	 				    title: false,
	 				    closeBtn:false, 
	 				    shadeClose: true,
	 				    shade: 0.8,
	 				    shift : 4,
	 				    area: ['426px', '291px'],
					    content: [base+'/message/toMsg/'+s_id+'/'+usernick, 'no']
					}); 
				}
			},
			error: $.ajaxError
		});
	}
//add by ylt 俱乐部列表
function searchPk(pageIndex){
	var jsonData = $("#pkForm").serializeObject();
	jsonData.currentPage = pageIndex;
	$.ajaxSec({
		type: 'POST',
		url: base+"/team/searchInviteDatas",
		data: jsonData,
		success: function(result){
			if(result.state=='error'){
				layer.msg(data.message.error[0],{icon:2});
			}else{
				var s_html = "";
				var x_html = "";
				var b_html = "";
				var teams = result.data.page.items;
				var currentPage =  result.data.page.currentPage;
				var pageSize =  result.data.page.pageSize;
				var totalCount =  result.data.page.totalCount;
				var left = "";
				var right = "";
				for (var i = 0; i < teams.length; i++) {
					var teaminfo = teams[i];
					if(i<3){
						s_html += "<li>" +
							"<div class='club_logo'>" +
								"<img src='"+ossPath+teaminfo.logo+"' onclick=\"javascript:window.open('"+base+"/team/tdetail/"+teaminfo.id+"')\" style='cursor:pointer;'/>" +
							"</div>" +
							"<div class='club_info'>" +
								"<p style='text-align: center;color: white;'>"+teaminfo.name+"</p>" +
								"<p class='f12 p_ml'>" +
									"<span>俱乐部能力值：</span>" +
									"<span>"+teaminfo.abilityValue+"</span>" +
								"</p>" +
								"<p class='f12 p_ml'>" +
									"<span>俱乐部战绩：</span>" +
									"<span>"+teaminfo.win_count+"胜"+teaminfo.draw_count+"平"+teaminfo.loss_count+"负</span>" +
								"</p>" +
								"<p class='f12 p_city p_ml'>" +
									"<span>俱乐部所在地：</span>" +
									"<span>"+teaminfo.city+"</span>" +
								"</p>" +
								"<p style='margin-top: 18px;margin-left: 20px;'>" +
									"<input type='button' value='私信' class='pk_btn' onclick=\"openMsg('"+teaminfo.id+"')\"/>" +
									"<input type='button' value='PK' class='pk_btn' onclick=\"inviteTeam('"+teaminfo.id+"','"+teaminfo.name+"','"+teaminfo.logo+"')\"/>" +
								"</p>" +
							"</div>" +
						"</li>";
					}else{
						x_html += "<li class='mtNagative'>" +
									"<div class='club_logo'>" +
										"<img src='"+ossPath+teaminfo.logo+"' onclick=\"javascript:window.open('"+base+"/team/tdetail/"+teaminfo.id+"')\" style='cursor:pointer;'/>" +
									"</div>" +
									"<div class='club_info'>" +
										"<p style='text-align: center;color: white;'>"+teaminfo.name+"</p>" +
										"<p class='f12 p_ml'>" +
											"<span>俱乐部能力值：</span>" +
											"<span>"+teaminfo.abilityValue+"</span>" +
										"</p>" +
										"<p class='f12 p_ml'>" +
											"<span>俱乐部战绩：</span>" +
											"<span>"+teaminfo.win_count+"胜"+teaminfo.draw_count+"平"+teaminfo.loss_count+"负</span>" +
										"</p>" +
										"<p class='f12 p_city p_ml'>" +
											"<span>俱乐部所在地：</span>" +
											"<span>"+teaminfo.city+"</span>" +
										"</p>" +
										"<p style='margin-top: 18px;margin-left: 20px;'>" +
											"<input type='button' value='私信' class='pk_btn' onclick=\"openMsg('"+teaminfo.id+"')\"/>" +
											"<input type='button' value='PK' class='pk_btn' onclick=\"inviteTeam('"+teaminfo.id+"','"+teaminfo.name+"','"+teaminfo.logo+"')\"/>" +
										"</p>" +
									"</div>	" +
								"</li>";
					}
				}
				if(teams.length > 0){
					var pageCount = Math.ceil(totalCount/pageSize);
					if(currentPage <= 1){
						left = "<a href='javascript:void(0);' class='turn_left'></a>";
					}else{
						left = "<a href='javascript:void(0);' class='turn_left' onclick='searchPk("+(currentPage-1)+")'></a>";
					}
					if(currentPage+1> pageCount){
						right = "<a href='javascript:void(0);' class='turn_right'></a>";
					}else{
						right = "<a href='javascript:void(0);' class='turn_right' onclick='searchPk("+(currentPage+1)+")'></a>";
					}
				}
				b_html = left + right;
				$("#sArea").html(s_html);
				$("#xArea").html(x_html);
				$("#bArea").html(b_html);
			}
		},
		error: $.ajaxError
	});	
	
	
}
