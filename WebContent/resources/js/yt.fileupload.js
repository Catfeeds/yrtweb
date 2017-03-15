var fileName = "";
	var oTimer = null;
	var suffix = "";
	$(document).ready(function() {
		window.document.getElementById("fileToUpload").disabled = false;
	});

	function getProgress() {
		var now = new Date();
		$.ajax({
			type : "post",
			dataType : "json",
			url : base + "/fileStatus/upfile/progress",
			data : now.getTime(),
			success : function(data) {
				console.log(data);
				$("#progress_percent").text(data.percent);
				$("#progress_bar").width(data.percent);
				$("#has_upload").text(data.mbRead);
				$("#upload_speed").text(data.speed);
			},
			error : function(err) {
				console.log(err);
				$("#progress_percent").text("Error");
			}
		});
	}

	/**
	 * 提交上传文件
	 */
	function fSubmit() {
		alert("提交上传文件");
		$("#process").show();
		$("#cancel").show();
		$("#info").show();
		$("#success_info").hide();
		//文件名
		fileName = $("#fileToUpload").val().split('/').pop().split('\\').pop();
		//进度和百分比
		$("#progress_percent").text("0%");
		$("#progress_bar").width("0%");
		$("#progress_all").show();
		oTimer =setInterval("getProgress()", 1000);
		ajaxFileUpload();
		//document.getElementById("upload_form").submit();
		window.document.getElementById("fileToUpload").disabled = true;
	}

	/**
	 * 上传文件
	 */
	function ajaxFileUpload() {
		$.ajaxFileUpload({
					url : base + '/upload/saveFile',
					secureuri : false,
					fileElementId : 'fileToUpload',
					dataType : 'json',
					data : {
						name : 'file',
						filetype: window.suffix,
					},
					success : function(data, status) {
						console.log(data);
							window.clearInterval(oTimer);
							if (data.state == 'success') {
							alert(data.message.success[0]);
								$("#info").hide();
								$("#success_info").show();
								$("#suc_file").val(data.data.url);
								$("#process").hide();
								$("#cancel").hide();
 								$("#fileToUpload").val("");
								window.document.getElementById("fileToUpload").disabled = false;
								//上传进度和上传速度清0
								$("#has_upload").text("0");
								$("#upload_speed").text("0");
								$("#progress_percent").text("0%");
								$("#progress_bar").width("0%");
							} else {
								$("#progress_all").hide();
								$("#fileToUpload").val("");
								alert(data.message.error[0]);
							}
					},
				})
		return false;
	}
	
	//显示弹框 
	function showCont(format) {
		window.suffix = format;
		alert(window.suffix);
		$("#TB_overlayBG").css({
			display : "block",
			height : $(document).height()
		});
		$(".yxbox").css(
				{
					left : ($("body").width() - $(".yxbox").width())
							/ 2 - 20 + "px",
					top : ($(window).height() - $(".yxbox").height())
							/ 2 + $(window).scrollTop() + "px",
					display : "block"
				});
	}
	// 关闭弹框 
	function closeCont() {
		$("#TB_overlayBG").hide();
		$(".yxbox").hide();
		window.location.reload();
	}
	function resetNavHeight() {
		var documentHeight;
		if (document.compatMode == 'BackCompat') {
			documentHeight = Math.max(document.body.clientHeight,
					document.body.scrollHeight);
		} else {
			documentHeight = Math.max(
					document.documentElement.clientHeight,
					document.documentElement.scrollHeight);
		}
		$('.left').height(documentHeight - 48);
	}
	
	function deleteFile(){
		alert("删除文件"+$("#suc_file").val());
		$.ajax({
			type : "post",
			dataType : "json",
			url : base + "/upload/deleteFile",
			data : {
				url:$("#suc_file").val()
				},
			success : function(data) {
					console.log(data);
				if (data.state == "error") {
					alert(data.message.error[0]);
				} else if (data.state == "success") {
					alert(data.message.success[0]);
				}
			},
		});
	}
	resetNavHeight();
	
	$(window).resize(resetNavHeight);