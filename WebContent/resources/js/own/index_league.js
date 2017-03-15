$(function(){
	var flag = $("#indexFlag").val();
	if(flag=="true"){
		loadNews();
		loadRecords('');
	}else{
		loadNews($("#league_id").val());
		loadRecords($("#league_id").val());
	}
	loadScorer('');
	loadCard('');
	loadPrice('');
	loadIntegral('.i_list ul li:first','','');
	loadIvs(null,$("#now_league_id").val());
});

function anistart(id) {
    var $frame = $(id);	
    var $wrap = $frame.parent();
    $frame.sly({
        horizontal: 1,
        itemNav: 'forceCentered',
        smart: 1,
        activateMiddle: 1,
        mouseDragging: 1,
        touchDragging: 1,
        releaseSwing: 1,
        startAt: 0,
        scrollBy: 1,
        speed: 300,
        elasticBounds: 1,
        easing: 'easeOutExpo',
        dragHandle: 1,
        dynamicHandle: 1,
        clickBar: 1,
        prev: $wrap.find('.new_left'),
        next: $wrap.find('.new_right')
    });
};

//加载联赛赛事信息
function loadRecords(league_id){
	$.ajax({
		type:"POST",
		url:base+"/record/eventRecords",
		data:{"league_id":league_id},
		dataType:"HTML",
		success:function(data){
			$("#race_frame").empty();
			$("#race_frame").html(data);
			anistart("#record_frame");
		}
	});
}

//载入新闻信息
function loadNews(league_id){
	  var tempHtml = '<img alt="数据加载中" src="'+base+'/resources/images/loading.gif" style="position: absolute; width: 40px;height: 40px;left: 490px;margin-top: 128px;">';
	$.ajax({
		type:"POST",
		url:base+"/league/news",
		data:{"pageSize":"25","league_id":league_id},
		dataType:"HTML",
		beforeSend:function(){
			$("#newsArea").empty();
			$("#newsArea").append(tempHtml);
		},
		success:function(data){
			$("#newsArea").empty();
			$("#newsArea").append(data);
		}
	});
}

//积分榜数据
function loadIntegral(dom,group_id,league_id){
	var l_id = '';
    if(league_id == ''){
	    l_id = $("#league_id").val();
    }else{
	    l_id = league_id;
    }
	  var tempHtml = '<img alt="数据加载中" src="'+base+'/resources/images/loading.gif" style="position: absolute; width: 40px;height: 40px;left: 150px;margin-top: 90px;">';
  	$.ajax({
  		type:"POST",
  		url:base+"/league/integral",
  		data:{"league_id":l_id,"group_id":group_id,"pageSize":"4"},
  		dataType:"HTML",
  		beforeSend:function(){
  			$("#jifenArea").empty();
  			$("#jifenArea").append(tempHtml);
  		},
  		success:function(data){
  			$("#jifenArea").empty();
  			$("#jifenArea").append(data);
  			$(dom).addClass("active").siblings().removeClass("active");
  			$("#a_integral").attr("href",base+"/league/integralList?league_id="+l_id);
  		}
  	});
}

//射手榜数据
function loadScorer(league_id){
	 var l_id = '';
	  if(league_id == ''){
		  l_id = $("#league_id").val();
	  }else{
		  l_id = league_id;
	  }
	  var tempHtml = '<img alt="数据加载中" src="'+base+'/resources/images/loading.gif" style="position: absolute; width: 40px;height: 40px;left: 150px;margin-top: 70px;">';
  	$.ajax({
  		type:"POST",
  		url:base+"/league/scorer",
  		data:{"league_id":l_id,"pageSize":"4"},
  		dataType:"HTML",
  		beforeSend:function(){
  			$("#scorerArea").empty();
  			$("#scorerArea").append(tempHtml);
  		},
  		success:function(data){
  			$("#scorerArea").empty();
  			$("#scorerArea").append(data);
  			$("#ss").css("color","#fff");
  			$("#hh").css("color","#999");
  			$("#a_scorer").attr("href",base+"/league/scorerRank?league_id="+l_id);
  		}
  	});
}

//身价榜数据
function loadPrice(league_id){
	 var l_id = '';
	  if(league_id == ''){
		  l_id = $("#league_id").val();
	  }else{
		  l_id = league_id;
	  }
	var tempHtml = '<img alt="数据加载中" src="'+base+'/resources/images/loading.gif" style="position: absolute; width: 40px;height: 40px;left: 476px;margin-top: 48px;">';
	$.ajax({
		type:"POST",
		url:base+"/league/slaveSingle",
		data:{"league_id":l_id,"pageSize":"4"},
		dataType:"HTML",
		beforeSend:function(){
			$("#priceArea").empty();
			$("#priceArea").append(tempHtml);
		},
		success:function(data){
			$("#priceArea").empty();
			$("#priceArea").append(data);
			$("#a_price").attr("href",base+"/league/toPrice?league_id="+l_id);
		}
	});
}

//红黄榜数据
function loadCard(league_id){
  var l_id = '';
  if(league_id == ''){
	  l_id = $("#league_id").val();
  }else{
	  l_id = league_id;
  }
  var tempHtml = '<img alt="数据加载中" src="'+base+'/resources/images/loading.gif" style="position: absolute; width: 40px;height: 40px;left: 150px;margin-top: 70px;">';
	$.ajax({
		type:"POST",
		url:base+"/league/cardList",
		data:{league_id:l_id,"pageSize":"4"},
		dataType:"HTML",
		beforeSend:function(){
			$("#cardArea").empty();
			$("#cardArea").append(tempHtml);
		},
		success:function(data){
			$("#cardArea").empty();
			$("#cardArea").append(data);
			$("#a_card").attr("href",base+"/league/toCard?league_id="+l_id);
		}
	});
}


function loadIvs(type,lid){
	var vflag = true;
	var iflag = true;
	if(type&&type==1)vflag=false;
	if(type&&type==2)iflag=false;
	if(vflag){
		$.loadSec("#league_index_videos",base+"/league/ivs",{pageSize:8,type:2,league_id:lid},function(){
			create_commont_list();
			$(".closeVideoDeatail").click(function () {
				$("#a1").html("");
				$(".masker").hide();
				$("#msg_content").val("");
				$('#video_detail').hide();
			});
		});
	}
	if(iflag){
		$.loadSec("#league_index_images",base+"/league/ivs",{pageSize:6,type:1,league_id:lid},function(){
			layer.ready(function(){
				layer.photos({
					photos: '#league_index_images'
				});
			});
		});
	}
}

