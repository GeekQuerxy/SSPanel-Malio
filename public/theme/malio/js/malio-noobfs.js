
// 常用操作
  function hideFeedback(e_id) {

    $('#' + e_id).hide()
  }

  function changeLang(lang){

    $.ajax({
      type: "POST",
      url: "/user/api/change-lang",
      dataType: "json",
      data: {
        lang: lang
      },
      success: function (data) {
        location.reload();
      }
    })
  }
  
  // index page
  function checkin() {

    $.ajax({
      type: "POST",
      url: "/user/checkin",
      dataType: "json",
      success: function (data) {
        $('#checkin-div').html('<a href="#" class="btn btn-icon disabled icon-left btn-primary"><i class="far fa-edit"></i> '+i18n['alredy-got-daily-bonus']+'</a>')
        swal(i18n['success-got-daily-bonus'], data.msg, 'success');
      },
      error: function (jqXHR) {
        swal('签到失败', '发送请求失败', 'error');
      }
    })
  }
  
  function loadTrafficChart() {

    $('#loadTrafficChart-div').html('<a id="loadTrafficChart" href="#" class="btn disabled btn-primary btn-progress">Progress</a>');
    $.ajax({
      type: "GET",
      url: "/user/trafficlog",
      dataType: "html",
      success: function (data) {
        $('#chartCardbox').html(function () {
          return '<div class="col-12">' + data + '</div>';
        });
        $('#loadTrafficChart').hide();
        $('#chartCardbox').show();
      }
    });
  }
  
  function trafficDountChat(lastusedTraffic, todayusedTraffic, unusedTraffic, last100, today100, unuse100) {

    ! function ($) {
      "use strict";
      var ChartC3 = function () {};
      ChartC3.prototype.init = function () {
          c3.generate({
            bindto: '#pie-chart',
            data: {
              columns: [
                [i18n.used + lastusedTraffic, last100],
                [i18n['used-today'] + todayusedTraffic, today100],
                [i18n.available + unusedTraffic, unuse100],
              ],
              type: 'donut'
            },
            color: {
              pattern: ["#dce6fb", "#ABC6FF", "#6777ef"]
            },
            donut: {
              label: {
                show: false
              }
            }
          });
  
        },
        $.ChartC3 = new ChartC3, $.ChartC3.Constructor = ChartC3
    }(window.jQuery),
  
    //initializing 
    function ($) {
      "use strict";
      $.ChartC3.init()
    }(window.jQuery);
  }
  
  // edit page
  $('#ss-random-password').click(function () {

    $('#ss-password').val(Math.random().toString(36).substr(2));
  })
  $('#ss-password-confirm').click(function () {

    $.ajax({
      type: "POST",
      url: "sspwd",
      dataType: "json",
      data: {
        sspwd: $("#ss-password").val()
      },
      success: function (data) {
        if (data.ret) {
          $("#ss-current-password").text($("#ss-password").val());
          swal({
            type: 'success',
            title: i18n['server-password-changed-successfully'],
            showCloseButton: true,
          })
        } else {
          swal({
            type: 'error',
            title: i18n['failed'],
            showCloseButton: true,
            text: data.msg
          })
        }
      }
    })
  })
  
  $("#method-confirm").click(function () {

    $.ajax({
      type: "POST",
      url: "method",
      dataType: "json",
      data: {
        method: $("#method-select").val()
      },
      success: function (data) {
        $("#current-method").html($("#method-select").val());
        if (data.ret) {
          swal({
            type: 'success',
            title: i18n['encryption-changed-successfully'],
            showCloseButton: true,
          })
        } else {
          swal({
            type: 'error',
            title: i18n['failed'],
            showCloseButton: true,
            text: data.msg
          })
        }
      }
    })
  })
  
  $("#protocol-obfs-confirm").click(function () {

    $.ajax({
      type: "POST",
      url: "ssr",
      dataType: "json",
      data: {
        protocol: $("#protocol-selection").val(),
        obfs: $("#obfs").val(),
        obfs_param: $("#obfs-param").val()
      },
      success: function (data) {
        if (data.ret) {
          $("#current-protocol").html($("#protocol-selection").val());
          $("#current-obfs").html($("#obfs").val());
          $("#current-obfs-param").html($("#obfs-param").val());
          swal({
            type: 'success',
            title: i18n['protocol-and-obfs-changed-successfully'],
            showCloseButton: true,
            text: data.msg
          })
        } else {
          swal({
            type: 'error',
            title: i18n['failed'],
            showCloseButton: true,
            text: data.msg
          })
        }
      }
    })
  })
  
  $('#reset-sub-link').click(function () {

    Swal.fire({
      title: i18n['reset-config-url-confirm-modal-title'],
      text: i18n['reset-config-url-confirm-modal-desc'],
      type: 'warning',
      showCancelButton: true,
      confirmButtonColor: '#d33',
      cancelButtonColor: '#3085d6',
      confirmButtonText: i18n['confirm'],
      cancelButtonText: i18n['cancel']
    }).then((result) => {
      if (result.value) {
        Swal.fire({
          title: i18n['config-url-has-been-reseted'],
          text: i18n['config-url-reset-modal-desc'],
          type: 'success',
          onClose: () => {
            window.location.assign('/user/url_reset')
          }
        })
      }
    })
  })
  
  $("#reset-port-confirm").click(function () {

    $.ajax({
      type: "POST",
      url: "resetport",
      dataType: "json",
      data: {},
      success: function (data) {
        if (data.ret) {
          $('#current-port').html(data.msg);
          swal({
            type: 'success',
            title: i18n['port-reseted-successfully'],
            text: i18n['new-port'] + data.msg,
            showCloseButton: true,
          })
        } else {
          swal({
            type: 'error',
            title: i18n['failed'],
            showCloseButton: true,
            text: data.msg
          })
        }
      }
    })
  })
  
  $("#portspecify").click(function () {

    $.ajax({
      type: "POST",
      url: "specifyport",
      dataType: "json",
      data: {
        port: $("#port-specify").val()
      },
      success: function (data) {
        if (data.ret) {
          $("#current-port-2").html($("#port-specify").val());
          swal({
            type: 'success',
            title: i18n['customize-port-successfully'],
            showCloseButton: true,
          })
        } else {
          swal({
            type: 'error',
            title: i18n['failed'],
            showCloseButton: true,
            text: data.msg
          })
        }
      }
    })
  })
  
  
  // invite page
  function buyInvite() {

    if (!($("#buy-invite-num").val())) {
      $('#invite-times-warn').show();
      return false;
    } else {
      $.ajax({
        type: "POST",
        url: "/user/buy_invite",
        dataType: "json",
        data: {
          num: $("#buy-invite-num").val(),
        },
        success: function (data) {
          if (data.ret) {
            swal({
              type: 'success',
              title: i18n['successful-purchase'],
              onClose: () => {
                window.location.assign('/user/invite')
              }
            })
          } else {
            swal({
              type: 'error',
              title: i18n['failed'],
              text: data.msg,
              footer: '<a href="/user/code">'+i18n['go-to-wallet']+'</a>'
            })
          }
        },
        error: function (jqXHR) {
          swal({
            type: 'error',
            title: i18n['failed'],
            text: '发送请求失败，请联系客服。'
          })
        }
      })
    }
  }
  
  function customInviteConfirm() {

    if (!($("#custom-invite-link").val())) {
      $('#custom-invite-feedback').show();
      return false;
    } else {
      $.ajax({
        type: "POST",
        url: "/user/custom_invite",
        dataType: "json",
        data: {
          customcode: $("#custom-invite-link").val()
        },
        success: function (data) {
          if (data.ret) {
            swal({
              type: 'success',
              title: i18n['customize-inivitation-link-successfully'],
              onClose: () => {
                window.location.assign('/user/invite')
              }
            })
          } else {
            swal({
              type: 'error',
              title: i18n['failed'],
              text: data.msg,
              footer: '<a href="/user/code">'+i18n['go-to-wallet']+'</a>'
            })
          }
        },
        error: function (jqXHR) {
          swal({
            type: 'error',
            title: i18n['failed'],
            text: '发送请求失败，请联系客服。'
          })
        }
      })
    }
  }
  
  
  // profile page
  function twofaNext() {

    $('#ga-modal').modal('hide');
    $('#ga-setp-2-modal').modal('show');
  }
  
  function twofaConfirm() {

    $.ajax({
      type: "POST",
      url: "gacheck",
      dataType: "json",
      data: {
        code: $("#ga-code").val()
      },
      success: function (data) {
        if (data.ret) {
          swal({
            type: 'success',
            title: data.msg,
            showCloseButton: true,
            onClose: () => {
              window.location.assign('/user/profile')
            }
          })
        } else {
          swal({
            type: 'error',
            title: data.msg,
            showCloseButton: true
          })
        }
      },
      error: function (jqXHR) {
        swal({
          type: 'error',
          title: i18n['failed'],
          text: data.msg + '，请联系客服。'
        })
      }
    })
  }
  
  $("#2fa-off").click(function () {

    $.ajax({
      type: "POST",
      url: "gaset",
      dataType: "json",
      data: {
        enable: 0
      },
      success: function (data) {
        if (data.ret) {
          swal({
            type: 'success',
            title: i18n['2fa-has-been-disabled'],
            showCloseButton: true,
            onClose: () => {
              window.location.assign('/user/profile')
            }
          })
        } else {
          swal({
            type: 'error',
            title: data.msg,
            showCloseButton: true
          })
        }
      },
      error: function (jqXHR) {
        swal({
          type: 'error',
          title: i18n['failed'],
          text: data.msg + '，请联系客服。'
        })
      }
    })
  })
  
  function passwordConfirm() {

    $.ajax({
      type: "POST",
      url: "password",
      dataType: "json",
      data: {
        oldpwd: $("#oldpwd").val(),
        pwd: $("#pwd").val(),
        repwd: $("#repwd").val()
      },
      success: function (data) {
        if (data.ret) {
          swal({
            type: 'success',
            title: i18n['password-changed-successfully'],
            showCloseButton: true,
            onClose: () => {
              window.location.assign('/user/logout')
            }
          })
        } else {
          swal({
            type: 'error',
            title: i18n['failed'],
            text: data.msg,
            showCloseButton: true,
          })
        }
      },
      error: function (jqXHR) {
        swal({
          type: 'error',
          title: i18n['failed'],
          text: data.msg + '，请联系客服。'
        })
      }
    })
  }
  
  function killConfirm() {

    $.ajax({
      type: "POST",
      url: "kill",
      dataType: "json",
      data: {
        passwd: $("#passwd").val(),
      },
      success: function (data) {
        console.log(data.ret);
        if (data.ret) {
          swal({
            type: 'success',
            title: i18n['your-account-has-been-deleted'],
            showCloseButton: true,
            onClose: () => {
              window.location.assign('/')
            }
          })
        } else {
          swal({
            type: 'error',
            title: i18n['failed'],
            showCloseButton: true,
            text: data.msg
          })
        }
      },
      error: function (jqXHR) {
        swal({
          type: 'error',
          title: i18n['failed'],
          text: data.msg + '，请联系客服。'
        })
      }
    })
  }
  
  
  // node page
  function urlChange(id, is_mu, rule_id) {

    var site = './node/' + id + '?ismu=' + is_mu + '&relay_rule=' + rule_id;
    document.getElementById('infoifram').src = site;
    $("#nodeinfo").modal();
  }
  
  
  // ticket pages
  function createTicket() {

    $('#create-ticket').attr("disabled", "disabled");
    $.ajax({
      type: "POST",
      url: "/user/ticket",
      dataType: "json",
      data: {
        content: $("#ticket-content").val(),
        markdown: $("#ticket-content").val(),
        title: $("#title").val()
      },
      success: function (data) {
        if (data.ret) {
          swal({
            type: 'success',
            title: i18n['submitted'],
            onClose: () => {
              window.location.assign('/user/ticket')
            }
          })
        } else {
          Swal.fire(
            i18n['failed'],
            data.msg,
            'error'
          )
          $('#create-ticket').removeAttr("disabled");
        }
      },
      error: function (jqXHR) {
        Swal.fire(
          '发生错误',
          '请联系客服',
          'error'
        )
        $('#create-ticket').removeAttr("disabled");
      }
    });
  }
  
  function replyTicket(id) {

    $('#ticket-reply').attr("disabled", "disabled");
    if ($("#ticket-content").val() == '') {
      Swal.fire(
        '请填写工单内容',
        data.msg,
        'error'
      )
      $('#ticket-reply').removeAttr("disabled");
      return false;
    }
    $.ajax({
      type: "PUT",
      url: "/user/ticket/" + id,
      dataType: "json",
      data: {
        content: $("#ticket-content").val(),
        markdown: '',
        title: '',
        status: 1
      },
      success: function (data) {
        if (data.ret) {
          swal({
            type: 'success',
            title: i18n['submitted'],
            onClose: () => {
              window.location.assign('/user/ticket/' + id + '/view')
            }
          })
        } else {
          Swal.fire(
            i18n['failed'],
            data.msg,
            'error'
          )
          $('#ticket-reply').removeAttr("disabled");
        }
      },
      error: function (jqXHR) {
        Swal.fire(
          '发生错误',
          '请联系客服',
          'error'
        )
        $('#ticket-reply').removeAttr("disabled");
      }
    });
  }
  
  function closeTicket(id) {

    $.ajax({
      type: "PUT",
      url: "/user/ticket/" + id,
      dataType: "json",
      data: {
        content: i18n['this-ticket-has-been-closed'],
        title: '',
        status: 0
      },
      success: function (data) {
        if (data.ret) {
          swal({
            type: 'success',
            title: i18n['this-ticket-has-been-closed'],
            onClose: () => {
              window.location.assign('/user/ticket')
            }
          })
        } else {
          Swal.fire(
            i18n['failed'],
            data.msg,
            'error'
          )
        }
      },
      error: function (jqXHR) {
        Swal.fire(
          '发生错误',
          '请联系客服',
          'error'
        )
      }
    });
  }
  
  
  // tutorial pages
  function createQRCode(elementId, link, title) {

    $('#' + elementId).popover({
      html: true,
      trigger: 'hover',
      placement: 'right',
      title: title,
      content: kjua({
        text: link,
        render: 'image',
        size: 224
      })
    });
  }
  
  function oneclickImport(client, subLink) {

  
    function isMobie() {
      if (bowser.osname == "iOS" || bowser.osname == "Android") {
        return true;
      }
    }
    var sublink = {
      surfboard: "surfboard:///install-config?url=" + encodeURIComponent(subLink),
      quantumult: "quantumult://configuration?server=" + btoa(subLink).replace(/=/g, '') + "&filter=YUhSMGNITTZMeTl0ZVM1dmMyOWxZMjh1ZUhsNkwzSjFiR1Z6TDNGMVlXNTBkVzExYkhRdVkyOXVaZw",
      shadowrocket: "shadowrocket://add/sub://" + btoa(subLink) + "?remarks=" + appName,
      surge: "surge:///install-config?url=" + encodeURIComponent(subLink),
      surge3: "surge3:///install-config?url=" + encodeURIComponent(subLink),
      clash: "clash://install-config?url=" + encodeURIComponent(subLink),
      ssr: "sub://"+btoa(subLink)
    }
    if (!isMobie() && client != 'clash' & client != 'ssr' ) {
      Swal.fire({
        title: i18n['notice'],
        html: i18n['unable-import-config-on-computer-modal'],
        type: 'warning',
        showCancelButton: true,
        confirmButtonText: i18n['proceed'],
        cancelButtonText: i18n['cancel'],
        focusClose: false,
        focusConfirm: false,
      }).then((result) => {
        if (result.value) {
          window.location.href = sublink[client];
        }
      })
    } else {
      window.location.href = sublink[client];
    }
  }
  
  
  // wallet
  function walletTopup(payment) {

    var price = parseFloat($("#amount").val());
    if (Number.isNaN(price) == true || price == 0 || price == null) {
      $('#no-amount-warn').show();
      return false;
    }
    if (paymentSystem == 'bitpayx') {
      bitpay(payment, price);
    }
    if (paymentSystem == 'f2fpay') {
      f2fpay(price);
    }
    if (paymentSystem == 'spay') {
      spay(price);
    }
    if (paymentSystem == 'codepay') {
      codepay(payment, price);
    }
    if (paymentSystem == 'tomatopay') {
      tmtpay(payment, price);
    }
    if (paymentSystem == 'flyfoxpay') {
      flyfox(payment, price);
    }
    if (paymentSystem == 'payjs') {
      payjs(price);
    }
    if (paymentSystem == 'f2fpay_payjs') {
      f2fpay_payjs(payment, price);
    }
    if (paymentSystem == 'stripe') {
      stripe(payment, price);
    }
    if (paymentSystem == 'payssion') {
      payssion(payment, price);
    }
    if (paymentSystem == 'yftpay') {
      yft(price);
    }
    if (paymentSystem == 'malio') {
      malioPay(payment, price);
    }
  }
  
  function codeTopup() {

    $.ajax({
      type: "POST",
      url: "code",
      dataType: "json",
      data: {
        code: $("#topup-code").val()
      },
      success: function (data) {
        if (data.ret) {
          swal({
            type: 'success',
            title: i18n['top-up-successful'],
            onClose: () => {
              window.location.assign('/user/code')
            }
          })
        } else {
          Swal.fire(
            i18n['failed'],
            data.msg,
            'error'
          )
        }
      }
    })
  }
  
  function stopAutorenew(orderId) {

    $.ajax({
      type: "DELETE",
      url: "/user/bought",
      dataType: "json",
      data: {
        id: orderId
      },
      success: function (data) {
        if (data.ret) {
          swal({
            type: 'success',
            title: i18n['disabled'],
            text: data.msg,
            onClose: () => {
              window.location.assign('/user/code')
            }
          })
        } else {
          Swal.fire(
            i18n['failed'],
            data.msg,
            'error'
          )
        }
      }
    });
  }
  
  
  // payments
  function bitpay(type, price, shopid=0) {

    if (type == 'alipay') {
      type = 'ALIPAY';
    } else if (type == 'wechat') {
      type = 'WECHAT';
    } else if (type == 'crypto') {
      type = 'CRYPTO';
    }
    console.log("将要使用 " + type + " 充值" + price + "元");
    if (isNaN(price) || price < 1 || price >= 1000) {
      if (isNaN(price)) {
        Swal.fire(
          '金额不能为空',
          '请输入正确的金额',
          'error'
        )
      } else if (price < 1) {
        Swal.fire(
          '金额不能低于1元',
          '请输入正确的金额',
          'error'
        )
      } else if (price > 1000) {
        Swal.fire(
          '金额不能超过1000元',
          '请输入正确的金额',
          'error'
        )
      }
    } else {
      var isMobile = /Android|webOS|iPhone|iPod|BlackBerry/i.test(navigator.userAgent);
      $.ajax({
        'url': "/user/payment/purchase",
        'data': {
          'price': price,
          'type': type,
          'mobile': isMobile,
        },
        'dataType': 'json',
        'type': "POST",
        success: function (data) {
          if (data.errcode == 0) {
            var url = ((document.location.toString()).split("#")[0]).split('?')[0];
            var user_location = ((url.split("//")[1]).split("/"))[2];
            if (user_location == 'code') {
              window.location.href = data.url;
            } else {
              $('#bitpayx-modal').modal({
                backdrop: 'static',
                keyboard: false
              })
              $('#bitpayx-modal').modal('show');
              $('#to-bitpayx').attr("href", data.url);
            }
          } else {
            Swal.fire(
              '发生错误',
              data.errmsg,
              'error'
            )
          }
        }
      });
    }
  }
  
  function f2fpay(price, shopid=0) {

    $('#f2fpay-modal').modal({
      backdrop: 'static',
      keyboard: false
    })
    $('#f2fpay-modal').modal('show');
    var pid = 0;
  
    $.ajax({
      type: "POST",
      url: "/user/payment/purchase",
      dataType: "json",
      data: {
        amount: price
      },
      success: function (data) {
        if (data.ret) {
          console.log(data);
          pid = data.pid;
          $("#f2fpay-qr").html(
            kjua({
              text: data.qrcode,
              render: 'image',
              size: 256
            })
          );
          $('#f2fpay-qr').attr('href', data.qrcode);
          $('#to-alipay-app').attr('href', data.qrcode);
          var url = ((document.location.toString()).split("#")[0]).split('?')[0];
          var user_location = ((url.split("//")[1]).split("/"))[2];
          if (user_location == 'code') {
            setTimeout(f, 1000);
          }
        } else {
          Swal.fire(
            '发生错误',
            data.msg,
            'error'
          )
        }
      },
      error: function (jqXHR) {
        Swal.fire(
          '发生错误',
          '请联系客服',
          'error'
        )
      }
    })
  
    function f() {
      $.ajax({
        type: "POST",
        url: "/payment/status",
        dataType: "json",
        data: {
          pid: pid
        },
        success: function (data) {
          if (data.result) {
            clearTimeout(tid);
            swal({
              type: 'success',
              title: '充值成功',
              onClose: () => {
                window.location.assign('/user/code')
              }
            })
          }
        },
        error: function (jqXHR) {
          console.log(jqXHR);
        }
      });
      tid = setTimeout(f, 1000); //循环调用触发setTimeout
    }
  }
  
  function spay(price) {

    $.ajax({
      'url': "/user/payment/purchase",
      'data': {
        'price': price,
      },
      'dataType': 'json',
      'type': "POST",
      success: function (data) {
        if (data.code == 0) {
          var url = ((document.location.toString()).split("#")[0]).split('?')[0];
          var user_location = ((url.split("//")[1]).split("/"))[2];
          if (user_location == 'code') {
            window.location.href = data.url;
          } else {
            $('#spay-modal').modal({
              backdrop: 'static',
              keyboard: false
            })
            $('#spay-modal').modal('show');
            $('#to-spay').attr("href", data.url);
          }
        } else {
          Swal.fire(
            '发生错误',
            data.msg,
            'error'
          )
        }
      }
    });
  }
  
  function codepay(type, price) {

    if (type == 'alipay') {
      type = 1;
    } else if (type == 'wechat') {
      type = 3;
    } else if (type == 'qqpay') {
      type = 2;
    }
    $.ajax({
      'url': "/user/code/codepay",
      'data': {
        'price': price,
        'type': type
      },
      'dataType': 'json',
      'type': "GET",
      success: function (data) {
        if (data.code == 0) {
          var url = ((document.location.toString()).split("#")[0]).split('?')[0];
          var user_location = ((url.split("//")[1]).split("/"))[2];
          if (user_location == 'code') {
            window.location.href = data.url;
          } else {
            $('#codepay-modal').modal({
              backdrop: 'static',
              keyboard: false
            })
            $('#codepay-modal').modal('show');
            $('#to-codepay').attr("href", data.url);
          }
        } else {
          Swal.fire(
            '发生错误',
            data.msg,
            'error'
          )
        }
      }
    });
  }
  
  function tmtpay(type, price) {

    if (type == 'wechat') {
      type = 'wxpay';
    }
    $.ajax({
      'url': "/user/payment/purchase",
      'data': {
        'price': price,
        'type': type,
      },
      'dataType': 'json',
      'type': "POST",
      success: function (data) {
        console.log(data);
        if (data.errcode == -1) {
          Swal.fire(
            '发生错误',
            data.errmsg,
            'error'
          )
        }
        if (data.errcode == 0) {
          var url = ((document.location.toString()).split("#")[0]).split('?')[0];
          var user_location = ((url.split("//")[1]).split("/"))[2];
          if (user_location == 'code') {
            pid = data.pid;
            if (type == "wxpay") {
              window.location.href = data.code;
            } else if (type == "alipay") {
              window.location.href = data.code;
            }
          } else {
            $('#tmtpay-modal').modal({
              backdrop: 'static',
              keyboard: false
            })
            $('#tmtpay-modal').modal('show');
            $('#to-tmtpay').attr("href", data.code);
          }
        }
      }
    });
  }
  
  function flyfox(type, price) {

    $.ajax({
      'url': "/user/payment/purchase",
      'data': {
        'price': price,
        'type': type,
      },
      'dataType': 'json',
      'type': "POST",
      success: function (data) {
        console.log(data);
        if (data.errcode == -1) {
          Swal.fire(
            '发生错误',
            data.errmsg,
            'error'
          )
        }
        if (data.errcode == 0) {
          var url = ((document.location.toString()).split("#")[0]).split('?')[0];
          var user_location = ((url.split("//")[1]).split("/"))[2];
          if (user_location == 'code') {
            pid = data.pid;
            window.location.href = data.code;
          } else {
            $('#flyfox-modal').modal({
              backdrop: 'static',
              keyboard: false
            })
            $('#flyfox-modal').modal('show');
            $('#to-flyfox').attr("href", data.code);
          }
        }
      }
    });
  }
  
  function payjs(price) {

    $('#payjs-modal').modal({
      backdrop: 'static',
      keyboard: false
    })
    $('#payjs-modal').modal('show');
    var pid = 0;
  
    $.ajax({
      type: "POST",
      url: "/user/payment/purchase",
      dataType: "json",
      data: {
        price: price,
        type: 'wechat'
      },
      success: function (data) {
        if (data.code == 0) {
          console.log(data);
          pid = data.pid;
          $("#payjs-qr").html(
            kjua({
              text: data.url,
              render: 'image',
              size: 256
            })
          );
          var url = ((document.location.toString()).split("#")[0]).split('?')[0];
          var user_location = ((url.split("//")[1]).split("/"))[2];
          if (user_location == 'code') {
            setTimeout(f, 1000);
          }
        } else {
          Swal.fire(
            '发生错误',
            data.msg,
            'error'
          )
        }
      },
      error: function (jqXHR) {
        Swal.fire(
          '发生错误',
          '请联系客服',
          'error'
        )
      }
    })
  
    function f() {
      $.ajax({
        type: "POST",
        url: "/payment/status",
        dataType: "json",
        data: {
          pid: pid
        },
        success: function (data) {
          if (data.result) {
            clearTimeout(tid);
            swal({
              type: 'success',
              title: '充值成功',
              onClose: () => {
                window.location.assign('/user/code')
              }
            })
          }
        },
        error: function (jqXHR) {
          console.log(jqXHR);
        }
      });
      tid = setTimeout(f, 1000); //循环调用触发setTimeout
    }
  }
  
  function f2fpay_payjs(type, price) {

    var pid = 0;
  
    $.ajax({
      type: "POST",
      url: "/user/payment/purchase",
      dataType: "json",
      data: {
        amount: price,
        payment: type
      },
      success: function (data) {
        if (data.ret) {
          console.log(data);
          if (type == 'alipay') {
            $('#f2fpay-modal').modal('show');
            pid = data.pid;
            $("#f2fpay-qr").html(
              kjua({
                text: data.qrcode,
                render: 'image',
                size: 256
              })
            );
            $('#f2fpay-qr').attr('href', data.qrcode);
            $('#to-alipay-app').attr('href', data.qrcode);
          } else {
            $('#payjs-modal').modal('show');
            pid = data.pid;
            $("#payjs-qr").html(
              kjua({
                text: data.qrcode,
                render: 'image',
                size: 256
              })
            );
          }
          var url = ((document.location.toString()).split("#")[0]).split('?')[0];
          var user_location = ((url.split("//")[1]).split("/"))[2];
          if (user_location == 'code') {
            setTimeout(f, 1000);
          }
  
        } else {
          Swal.fire(
            '发生错误',
            data.msg,
            'error'
          )
        }
      },
      error: function (jqXHR) {
        Swal.fire(
          '发生错误',
          '请联系客服',
          'error'
        )
      }
    })
  
    function f() {
      $.ajax({
        type: "POST",
        url: "/payment/status",
        dataType: "json",
        data: {
          pid: pid
        },
        success: function (data) {
          if (data.result) {
            clearTimeout(tid);
            swal({
              type: 'success',
              title: '充值成功',
              onClose: () => {
                window.location.assign('/user/code')
              }
            })
          }
        },
        error: function (jqXHR) {
          console.log(jqXHR);
        }
      });
      tid = setTimeout(f, 1000); //循环调用触发setTimeout
    }
  }
  
  function stripe(type, price, shopid=0) {

    console.log('---------Stripe 函数 Start--------')
    var pid = 0;
    if (isNaN(price) || price <= 0) {
      if (isNaN(price)) {
        Swal.fire(
          '金额不能为空',
          '请输入正确的金额',
          'error'
        )
      } else if (price <= 0) {
        Swal.fire(
          '金额不能是0元或负数',
          '请输入正确的金额',
          'error'
        )
      }
    } else {
      $.ajax({
        'url': "/user/payment/purchase",
        'data': {
          'price': price,
          'type': type,
        },
        'dataType': 'json',
        'type': "POST",
        success: function (data) {
          if (data.errcode == 0) {
            var url = ((document.location.toString()).split("#")[0]).split('?')[0];
            var user_location = ((url.split("//")[1]).split("/"))[2];
  
            if (type == 'alipay') {
              if (user_location == 'code') {
                window.location.href = data.url;
              } else {
                $('#stripe-alipay-modal').modal({
                  backdrop: 'static',
                  keyboard: false
                })
                $('#stripe-alipay-modal').modal('show');
                $('#to-stripe').attr("href", data.url);
              }
            } else if (type == 'wechat') {
              pid = data.pid;
              $("#stripe-qr").html(
                kjua({
                  text: data.url,
                  render: 'image',
                  size: 256
                })
              );
              $('#stripe-wechat-modal').modal({
                backdrop: 'static',
                keyboard: false
              })
              $('#stripe-wechat-modal').modal('show');
              if (user_location == 'code') {
                setTimeout(f, 1000);
              }
            } else if (type == 'creditCard') {
              stripejs.redirectToCheckout({
                sessionId: data.checkoutSessionId
              }).then(function (result) {
                console.log('Failed to process payment.');
              });
            }
          } else {
            Swal.fire(
              '发生错误',
              data.errmsg,
              'error'
            )
          }
        }
      });
    }
  
    function f() {
      $.ajax({
        type: "POST",
        url: "/payment/status",
        dataType: "json",
        data: {
          pid: pid
        },
        success: function (data) {
          if (data.result) {
            clearTimeout(tid);
            swal({
              type: 'success',
              title: '充值成功',
              onClose: () => {
                window.location.assign('/user/code')
              }
            })
          }
        },
        error: function (jqXHR) {
          console.log(jqXHR);
        }
      });
      tid = setTimeout(f, 1000); //循环调用触发setTimeout
    }
  }
  
  function payssion(type, price) {

    $.ajax({
      'url': "/user/payment/purchase",
      'data': {
        'price': price,
        'type': type
      },
      'dataType': 'json',
      'type': "POST",
      success: function (data) {
        if (data.ret == 1) {
          var url = ((document.location.toString()).split("#")[0]).split('?')[0];
          var user_location = ((url.split("//")[1]).split("/"))[2];
          if (user_location == 'code') {
            window.location.href = data.url;
          } else {
            $('#payssion-modal').modal({
              backdrop: 'static',
              keyboard: false
            })
            $('#payssion-modal').modal('show');
            $('#to-payssion').attr("href", data.url);
          }
        } else {
          Swal.fire(
            '发生错误',
            data.msg,
            'error'
          )
        }
      }
    });
  }
  
  function yft(price) {

    console.log('---------yft 函数 Start--------')
    var pid = 0;
    if (isNaN(price) || price <= 0) {
      if (isNaN(price)) {
        Swal.fire(
          '金额不能为空',
          '请输入正确的金额',
          'error'
        )
      } else if (price <= 0) {
        Swal.fire(
          '金额不能是0元或负数',
          '请输入正确的金额',
          'error'
        )
      }
    } else {
      $.ajax({
        'url': "/user/payment/purchase",
        'data': {
          'total_fee': price,
        },
        'dataType': 'json',
        'type': "POST",
        success: function (data) {
          if (data.errcode == 0) {
            var url = ((document.location.toString()).split("#")[0]).split('?')[0];
            var user_location = ((url.split("//")[1]).split("/"))[2];
  
            if (user_location == 'code') {
              window.location.href = data.url;
            } else {
              $('#yftpay-modal').modal({
                backdrop: 'static',
                keyboard: false
              })
              $('#yftpay-modal').modal('show');
              $('#to-yftpay').attr("href", data.url);
            }
          } else {
            Swal.fire(
              '发生错误',
              data.errmsg,
              'error'
            )
          }
        }
      });
    }
  }
  
  function malioPay(type, price, shopid=0) {

    console.log('---------malioPay func start--------')
    if (isNaN(price) || price <= 0) {
      if (isNaN(price)) {
        Swal.fire(
          '金额不能为空',
          '请输入正确的金额',
          'error'
        )
      } else if (price <= 0) {
        Swal.fire(
          '金额不能是0元或负数',
          '请输入正确的金额',
          'error'
        )
      }
    } else {
      $.ajax({
        'url': "/user/payment/purchase",
        'data': {
          'price': price,
          'type': type,
          'shopid': shopid
        },
        'dataType': 'json',
        'type': "POST",
        success: function (data) {
          if (data.ret) {
            if (data.type == 'url') {
              window.location.href = data.url;
            } else {
              window.location.href = '/user/qrcode?type='+type
                +'&qrcode='+encodeURIComponent(data.url)
                +'&tradeno='
                +data.tradeno
                +'&price='+price;
            }
          } else {
            Swal.fire(
              '发生错误',
              data.errmsg,
              'error'
            )
          }
        }
      });
    }
  }

  function customPay(type, price, shopid=0) {


    if (isNaN(price) || price <= 0) {
      if (isNaN(price)) {
        Swal.fire(
          '金额不能为空',
          '请输入正确的金额',
          'error'
        )
      } else if (price <= 0) {
        Swal.fire(
          '金额不能是0元或负数',
          '请输入正确的金额',
          'error'
        )
      }
      return;
    }

    $.ajax({
      'url': "/user/payment/purchase",
      'data': {
        'price': price,
        'type': type,
        'shopid': shopid
      },
      'dataType': 'json',
      'type': "POST",
      success: function (data) {
        if (data.ret) {
            window.location.href = data.url;
        } else {
          Swal.fire(
            '发生错误',
            data.errmsg,
            'error'
          )
        }
      }
    });
  }
  
  // shop
  var shop = {
    'id': '1'
  };
  var coupon = {
    'code': '',
    'onetime': 1,
    'shop': [''],
    'credit': 0
  };
  var confirmShop = {
    'id': '',
    'price': 0,
    'autorenew': 0
  };
  
  $('.go-to-buy-page').click(function () {

    $('#main-page').hide();
    $('#buy-page').show();
  })

  function subscribePlan(plan){

    $('#main-page').hide();
    $('#buy-page').show();
    selectItem('plan', plan);
  }
  
  function backToShop() {

    $('#buy-page').hide();
    $('#main-page').show();
  }
  
  function updateCoupon() {

    if ($("#coupon-code").val() == '') {
      $('#coupon-feedback').text('请输入优惠码');
      $('#coupon-feedback').show();
      return false
    }
    $.ajax({
      type: "POST",
      url: "coupon_check",
      dataType: "json",
      data: {
        coupon: $("#coupon-code").val(),
        shop: shop.id
      },
      success: (data) => {
        if (data.ret) {
          coupon = {
            'code': $("#coupon-code").val(),
            'onetime': data.onetime,
            'shop': (data.shop).split(","),
            'credit': data.credit
          }
          $('#coupon-btn').html('<i class="fas fa-tag"></i> 当前优惠码: ' + coupon.code);
          $('#coupon-modal').modal('hide');
          updateCheckoutInfo();
        } else {
          $('#coupon-feedback').text(data.msg);
          $('#coupon-feedback').show();
        }
      }
    })
  
  };
  
  function cancelCoupon() {

    coupon = {
      'code': '',
      'onetime': 1,
      'shop': [''],
      'credit': 0
    };
    $("#coupon-code").val("");
    $('#coupon-btn').html('<i class="fas fa-tag"></i> 使用优惠码');
    $('#coupon-feedback').hide();
  }
  
  function updateCheckoutInfo() {

    console.log('############## 更新商品信息  ##############')
    var plan = $('#plan-selection .active').attr('id');
    var time = $('#time-selection .active').attr('id');
    var payment = $('#payment-selection .active').attr('id');
  
    $.ajax({
      type: "GET",
      url: "shop/getplaninfo",
      dataType: "json",
      data: {
        num: plan,
        time: time
      },
      success: function (data) {
        if (data.ret) {
          shop = {
            'id': data.id,
            'name': data.name,
            'price': data.price,
          }

          // 如果发现这个会员时长id为0，则active下一个时间
          var months = ['1month', '3month', '6month' ,'12month'];
          if(data.id == 0 || data.id == '0') {
            console.log('id=0, active next plan time', months.indexOf(time))
            selectItem('time', months[(months.indexOf(time))+1])
            updateCheckoutInfo()
            return 0;
          }
  
          console.log('商品信息', data);
          var discount_amount = (coupon.credit / 100 * shop.price).toFixed(2); // 打折的金额
          var total_after_discout = (data.price - discount_amount).toFixed(2); // 打折后的总价
          console.log('打折的金额：', discount_amount);
          console.log('打折后的总价', total_after_discout);
  
  
          if (coupon.code != '') {
            if ((coupon.shop).indexOf(data.id.toString()) == -1 && coupon.shop[0] != '') {
              total_after_discout = data.price
              console.log('优惠码不适用：', coupon.code)
            }
          }
  
          console.log('用户余额：', userMoney);
          var payAmount = 0; // 还需要支付的金额
          if (total_after_discout - userMoney > 0) {
            payAmount = (total_after_discout - userMoney).toFixed(2);
            $('#account-money').text('¥ -' + userMoney);
          } else {
            $('#account-money').text('¥ -' + total_after_discout);
          }
          console.log('还需要支付的金额：', payAmount);
  
          if (coupon.code != '') {
            $('#coupon-row').show();
            $('#coupon-money').text('¥ -' + discount_amount);
            shop.price = total_after_discout;
            if ((coupon.shop).indexOf(data.id.toString()) == -1 && coupon.shop[0] != '') {
              $('#coupon-money').text('不适用于此商品');
            }
          }
          $('#shop-name').text(shop.name);
          $('#total').text('¥ ' + data.price);
          $('#pay-amount').text('¥ ' + payAmount);
        }
        console.log('############## 更新商品信息 END  ##############')
      }
    })
  }
  
  function selectItem(area, item) {

    $('#' + area + '-selection .active').removeClass('active');
    $('#' + item).addClass('active');

    if (area == 'plan') {
      $.ajax({
        type: "GET",
        url: "shop/getplantime",
        dataType: "json",
        data: {
          num: item
        },
        success: function (data) {
          if (data.ret) {
            plan_time = data.plan_time;
            if (!plan_time.includes('1month')) {
              $('#1month').hide()
            } else {
              $('#1month').show()
            }
            if (!plan_time.includes('3month')) {
              $('#3month').hide()
            } else {
              $('#3month').show()
            }
            if (!plan_time.includes('6month')) {
              $('#6month').hide()
            } else {
              $('#6month').show()
            }
            if (!plan_time.includes('12month')) {
              $('#12month').hide()
            } else {
              $('#12month').show()
            }
          }
        }
      })
    }

    updateCheckoutInfo()
  }
  
  function buyConfirm(shopId) {

    console.log(confirmShop);
    $.ajax({
      type: "POST",
      url: "buy",
      dataType: "json",
      data: {
        coupon: coupon.code,
        shop: shopId,
        autorenew: confirmShop.autorenew,
        disableothers: 1
      },
      success: function (data) {
        if (data.ret) {
          swal({
            type: 'success',
            title: '购买成功',
            onClose: () => {
              window.location.assign('/user')
            }
          })
        } else {
          Swal.fire(
            '发生错误',
            data.msg,
            'error'
          )
        }
      },
      error: function (jqXHR) {
        Swal.fire(
          '发生错误',
          '请联系客服',
          'error'
        )
      }
    })
  }
  
  function topUp(price, payment, shopid=null) {

    if (paymentSystem == 'bitpayx') {
      bitpay(payment, price,shopid);
    }
    if (paymentSystem == 'f2fpay') {
      f2fpay(price,shopid);
    }
    if (paymentSystem == 'spay') {
      spay(price);
    }
    if (paymentSystem == 'codepay') {
      codepay(payment, price);
    }
    if (paymentSystem == 'tomatopay') {
      tmtpay(payment, price);
    }
    if (paymentSystem == 'flyfoxpay') {
      flyfox(payment, price);
    }
    if (paymentSystem == 'payjs') {
      payjs(price);
    }
    if (paymentSystem == 'f2fpay_payjs') {
      f2fpay_payjs(payment, price);
    }
    if (paymentSystem == 'stripe') {
      stripe(payment, price,shopid);
    }
    if (paymentSystem == 'payssion') {
      payssion(payment, price);
    }
    if (paymentSystem == 'yftpay') {
      yft(price);
    }
    if (paymentSystem == 'malio') {
      malioPay(payment, price,shopid);
    }
    if (paymentSystem == 'custom') {
      customPay(payment, price, shopid);
    }
    tid = setTimeout(f, 1000);
  
    function f() {
      $.ajax({
        'type': "GET",
        'url': "/user/money",
        dataType: "json",
        async: false,
        success: function (data) {
          if (data.ret) {
            console.log(confirmShop);
            if (parseFloat(data.money) >= parseFloat(confirmShop.price)) {
              clearTimeout(tid);
              buyConfirm(confirmShop.id);
            }
          }
        },
        error: function (jqXHR) {
          console.log(jqXHR);
        }
      });
      tid = setTimeout(f, 1000); //循环调用触发setTimeout
    }
  }
  
  $('#pay-confirm').click(function () {

    console.log('############## 按下立即支付按钮  ##############')
    $('#pay-confirm').attr("disabled", "disabled");
  
    $.ajax({
      type: "GET",
      url: "shop/getplaninfo",
      dataType: "json",
      data: {
        num: $('#plan-selection .active').attr('id'),
        time: $('#time-selection .active').attr('id')
      },
      success: function (data) {
        if (data.ret) {
          console.log('当前coupon为：', coupon);
          if (coupon.code != '' && coupon.shop[0] != '' && (coupon.shop).indexOf(data.id.toString()) == -1) {
            Swal.fire(
              '发生错误',
              '此优惠码不适用于此商品',
              'error'
            )
            $('#pay-confirm').removeAttr("disabled");
            return false;
          }
          console.log('planinfo：', data);
          confirmShop.id = data.id;
          confirmShop.price = data.price;
          if (coupon.code != '') {
            var discount_amount = ((coupon.credit / 100) * data.price).toFixed(2); // 打折的金额
            console.log('打折的金额为：', discount_amount);
            var total_after_discout = (data.price - discount_amount).toFixed(2); // 打折后的总价
            console.log('折后总价为：', total_after_discout)
            confirmShop.price = total_after_discout;
          }
          if ($('#autorenew-selection .active').attr('id') == 'autorenew-on') {
            confirmShop.autorenew = 1
          };
          shop = {
            'id': data.id,
            'name': data.name,
            'price': data.price,
          }
  
          var payment = $('#payment-selection .active').attr('id');
          var need_to_pay_price = (confirmShop.price - userMoney).toFixed(2);
          console.log('confirShop的值为：', confirmShop);
          console.log('用户余额为：', userMoney);
          console.log('need_to_pay_price的值为：', need_to_pay_price);
  
          if (need_to_pay_price <= 0) {
            buyConfirm(confirmShop.id);
          } else {
            topUp(need_to_pay_price, payment, confirmShop.id);
          }
          console.log('############## 按下立即支付按钮 END  ##############')
        } else {
          return;
        }
      }
    })
  })
  
  function buyTrafficPackage() {

    $.ajax({
      type: "POST",
      url: "shop/buytrafficpackage",
      dataType: "json",
      data: {
        shopid: $('input[name=traffic-package-radio]:checked').val(),
      },
      success: function (data) {
        if (data.ret) {
          swal({
            type: 'success',
            title: '请求成功',
            text: data.msg,
          })
        } else {
          Swal.fire(
            '发生错误',
            data.msg,
            'error'
          )
        }
      }
    })
  }
  
  function legacySelect(shopId) {

    confirmShop.id = shopId;
  }
  
  function legacyBuy() {

    if ($('#legacy-autorenew').is(':checked')) {
      confirmShop.autorenew = 1;
    }
    buyConfirm(confirmShop.id);
  }
  
  function legacyModalNext() {

    var couponCode = $('#legacy-coupon').val();
    if (couponCode != '') {
      $.ajax({
        type: "POST",
        url: "coupon_check",
        dataType: "json",
        data: {
          coupon: couponCode,
          shop: confirmShop.id
        },
        success: (data) => {
          if (data.ret) {
            coupon = {
              'code': $("#legacy-coupon").val(),
              'onetime': data.onetime,
              'shop': (data.shop).split(","),
              'credit': data.credit
            }
            console.log('成功获取legacy-coupon');
            $('#legacy-modal-1').modal('hide');
  
            $('#legacy-shop-name').show();
            $('#legacy-discount').show();
            $('#legacy-total').show();
            $('#legacy-shop-name').text('商品名称: ' + data.name);
            $('#legacy-discount').text('优惠额度: ' + data.credit + '%');
            $('#legacy-total').text('折后总价: ' + data.total);
            $('#legacy-modal-2').modal('show');
          } else {
            $('#legacy-coupon-feedback').text(data.msg);
            $('#legacy-coupon-feedback').show();
          }
        }
      })
    } else {
      $('#legacy-modal-1').modal('hide');
      $('#legacy-modal-2').modal('show');
    }
  }
  
  
  // relay
  $('#add-relay-rule').click(function () {

    $.ajax({
      type: "POST",
      url: "/user/relay",
      dataType: "json",
      data: {
        source_node: $('#source_node').val(),
        dist_node: $('#dist_node').val(),
        port: $('#port').val(),
        priority: $('#priority').val()
      },
      success: (data) => {
        if (data.ret) {
          Swal.fire({
            title: '成功添加中转规则',
            type: 'success',
            onClose: () => {
              window.location.assign('/user/relay')
            }
          })
        } else {
          Swal.fire(
            '发生错误',
            data.msg,
            'error'
          )
        }
      }
    });
  })
  
  function updateRelayRule(rule_id) {

    $.ajax({
      type: 'PUT',
      url: '/user/relay/' + rule_id,
      dataType: 'json',
      data: {
        source_node: $('#source_node').val(),
        dist_node: $('#dist_node').val(),
        port: $('#port').val(),
        priority: $('#priority').val()
      },
      success: (data) => {
        if (data.ret) {
          Swal.fire({
            title: '已更新中转规则',
            type: 'success',
            onClose: () => {
              window.location.assign('/user/relay')
            }
          })
        } else {
          Swal.fire(
            '发生错误',
            data.msg,
            'error'
          )
        }
      }
    });
  }
  
  function deleteRelayRule(rule_id) {

    Swal.fire({
      title: '确定删除此中转规则?',
      type: 'info',
      showCancelButton: true,
      confirmButtonColor: '#3085d6',
      cancelButtonColor: '#d33',
      cancelButtonText: '取消',
      confirmButtonText: '确定删除'
    }).then((result) => {
      if (result.value) {
        $.ajax({
          type: "DELETE",
          url: "/user/relay",
          dataType: "json",
          data: {
            id: rule_id
          },
          success: (data) => {
            if (data.ret) {
              Swal.fire({
                title: '已删除中转规则',
                type: 'success',
                onClose: () => {
                  window.location.assign('/user/relay')
                }
              })
            } else {
              Swal.fire(
                '发生错误',
                data.msg,
                'error'
              )
            }
          }
        });
      }
    })
  }
  
  // stisla srcipt.js
  "use strict";
  
  // ChartJS
  if (window.Chart) {
    Chart.defaults.global.defaultFontFamily = "'Nunito', 'Segoe UI', 'Arial'";
    Chart.defaults.global.defaultFontSize = 12;
    Chart.defaults.global.defaultFontStyle = 500;
    Chart.defaults.global.defaultFontColor = "#999";
    Chart.defaults.global.tooltips.backgroundColor = "#000";
    Chart.defaults.global.tooltips.bodyFontColor = "rgba(255,255,255,.7)";
    Chart.defaults.global.tooltips.titleMarginBottom = 10;
    Chart.defaults.global.tooltips.titleFontSize = 14;
    Chart.defaults.global.tooltips.titleFontFamily = "'Nunito', 'Segoe UI', 'Arial'";
    Chart.defaults.global.tooltips.titleFontColor = '#fff';
    Chart.defaults.global.tooltips.xPadding = 15;
    Chart.defaults.global.tooltips.yPadding = 15;
    Chart.defaults.global.tooltips.displayColors = false;
    Chart.defaults.global.tooltips.intersect = false;
    Chart.defaults.global.tooltips.mode = 'nearest';
  }
  
  // DropzoneJS
  if (window.Dropzone) {
    Dropzone.autoDiscover = false;
  }
  
  // Basic confirm box
  $('[data-confirm]').each(function () {
    var me = $(this),
      me_data = me.data('confirm');
  
    me_data = me_data.split("|");
    me.fireModal({
      title: me_data[0],
      body: me_data[1],
      footerClass: "bg-whitesmoke br",
      buttons: [{
          text: me.data('confirm-text-yes') || '确定',
          class: 'btn btn-danger btn-shadow',
          handler: function () {
            eval(me.data('confirm-yes'));
          }
        },
        {
          text: me.data('confirm-text-cancel') || '取消',
          class: 'btn btn-secondary',
          handler: function (modal) {
            $.destroyModal(modal);
            eval(me.data('confirm-no'));
          }
        }
      ]
    })
  });
  
  // Global
  $(function () {
    //console.log(window.location.href);
    var url = ((document.location.toString()).split("#")[0]).split('?')[0];
    var user_location = ((url.split("//")[1]).split("/"));
    var current = '';
    if (user_location.length == 2) {
      current = $(".sidebar-menu a[href$='/user']");
    } else if (user_location.length >= 3) {
      if (user_location[2] == 'ticket') {
        current = $(".sidebar-menu a[href$='#ticket']");
        current.addClass('has-dropdown');
      } else if (user_location[2] == 'detect') {
        current = $(".sidebar-menu a[href$='#detect']");
        current.addClass('has-dropdown');
      } else if (user_location[2] == 'relay' || user_location[2] == 'edit') {
        current = $(".sidebar-menu a[href$='#node-settings']");
        current.addClass('has-dropdown');
      } else {
        var query_str = ".sidebar-menu a[href$='/user/" + user_location[2] + "']";
        current = $(query_str);
      }
    }
    current.parent().addClass('active');
    //console.log(user_location, current)
    // end malio
  
    let sidebar_nicescroll_opts = {
        cursoropacitymin: 0,
        cursoropacitymax: .8,
        zindex: 892
      },
      now_layout_class = null;
  
    var sidebar_sticky = function () {
      if ($("body").hasClass('layout-2')) {
        $("body.layout-2 #sidebar-wrapper").stick_in_parent({
          parent: $('body')
        });
        $("body.layout-2 #sidebar-wrapper").stick_in_parent({
          recalc_every: 1
        });
      }
    }
    sidebar_sticky();
  
    var sidebar_nicescroll;
    var update_sidebar_nicescroll = function () {
      let a = setInterval(function () {
        if (sidebar_nicescroll != null)
          sidebar_nicescroll.resize();
      }, 10);
  
      setTimeout(function () {
        clearInterval(a);
      }, 600);
    }
  
    var sidebar_dropdown = function() {
      if($(".main-sidebar").length) {
        $(".main-sidebar").niceScroll(sidebar_nicescroll_opts);
        sidebar_nicescroll = $(".main-sidebar").getNiceScroll();
  
        $(".main-sidebar .sidebar-menu li a.has-dropdown").off('click').on('click', function() {
          var me     = $(this);
          var active = false;
          if(me.parent().hasClass("active")){
            active = true;
          }
          
          $('.main-sidebar .sidebar-menu li.active > .dropdown-menu').slideUp(500, function() {
            update_sidebar_nicescroll();          
            return false;
          });
          
          $('.main-sidebar .sidebar-menu li.active').removeClass('active');
  
          if(active==true) {
            me.parent().removeClass('active');          
            me.parent().find('> .dropdown-menu').slideUp(500, function() {            
              update_sidebar_nicescroll();
              return false;
            });
          }else{
            me.parent().addClass('active');          
            me.parent().find('> .dropdown-menu').slideDown(500, function() {            
              update_sidebar_nicescroll();
              return false;
            });
          }
  
          return false;
        });
  
        $('.main-sidebar .sidebar-menu li.active > .dropdown-menu').slideDown(500, function() {
          update_sidebar_nicescroll();        
          return false;
        });
      }
    }
    sidebar_dropdown();
  
    if ($("#top-5-scroll").length) {
      $("#top-5-scroll").css({
        height: 315
      }).niceScroll();
    }
  
    $(".main-content").css({
      minHeight: $(window).outerHeight() - 108
    })
  
    $(".nav-collapse-toggle").click(function () {
      $(this).parent().find('.navbar-nav').toggleClass('show');
      return false;
    });
  
    $(document).on('click', function (e) {
      $(".nav-collapse .navbar-nav").removeClass('show');
    });
  
    var toggle_sidebar_mini = function (mini) {
      let body = $('body');
  
      if (!mini) {
        body.removeClass('sidebar-mini');
        $(".main-sidebar").css({
          overflow: 'hidden'
        });
        setTimeout(function () {
          $(".main-sidebar").niceScroll(sidebar_nicescroll_opts);
          sidebar_nicescroll = $(".main-sidebar").getNiceScroll();
        }, 500);
        $(".main-sidebar .sidebar-menu > li > ul .dropdown-title").remove();
        $(".main-sidebar .sidebar-menu > li > a").removeAttr('data-toggle');
        $(".main-sidebar .sidebar-menu > li > a").removeAttr('data-original-title');
        $(".main-sidebar .sidebar-menu > li > a").removeAttr('title');
      } else {
        body.addClass('sidebar-mini');
        body.removeClass('sidebar-show');
        sidebar_nicescroll.remove();
        sidebar_nicescroll = null;
        $(".main-sidebar .sidebar-menu > li").each(function () {
          let me = $(this);
  
          if (me.find('> .dropdown-menu').length) {
            me.find('> .dropdown-menu').hide();
            me.find('> .dropdown-menu').prepend('<li class="dropdown-title pt-3">' + me.find('> a').text() + '</li>');
          } else {
            me.find('> a').attr('data-toggle', 'tooltip');
            me.find('> a').attr('data-original-title', me.find('> a').text());
            $("[data-toggle='tooltip']").tooltip({
              placement: 'right'
            });
          }
        });
      }
    }
  
    $("[data-toggle='sidebar']").click(function () {
      var body = $("body"),
        w = $(window);
  
      if (w.outerWidth() <= 1024) {
        body.removeClass('search-show search-gone');
        if (body.hasClass('sidebar-gone')) {
          body.removeClass('sidebar-gone');
          body.addClass('sidebar-show');
        } else {
          body.addClass('sidebar-gone');
          body.removeClass('sidebar-show');
        }
  
        update_sidebar_nicescroll();
      } else {
        body.removeClass('search-show search-gone');
        if (body.hasClass('sidebar-mini')) {
          toggle_sidebar_mini(false);
        } else {
          toggle_sidebar_mini(true);
        }
      }
  
      return false;
    });
  
    var toggleLayout = function () {
      var w = $(window),
        layout_class = $('body').attr('class') || '',
        layout_classes = (layout_class.trim().length > 0 ? layout_class.split(' ') : '');
  
      if (layout_classes.length > 0) {
        layout_classes.forEach(function (item) {
          if (item.indexOf('layout-') != -1) {
            now_layout_class = item;
          }
        });
      }
  
      if (w.outerWidth() <= 1024) {
        if ($('body').hasClass('sidebar-mini')) {
          toggle_sidebar_mini(false);
          $('.main-sidebar').niceScroll(sidebar_nicescroll_opts);
          sidebar_nicescroll = $(".main-sidebar").getNiceScroll();
        }
  
        $("body").addClass("sidebar-gone");
        $("body").removeClass("layout-2 layout-3 sidebar-mini sidebar-show");
        $("body").off('click touchend').on('click touchend', function (e) {
          if ($(e.target).hasClass('sidebar-show') || $(e.target).hasClass('search-show')) {
            $("body").removeClass("sidebar-show");
            $("body").addClass("sidebar-gone");
            $("body").removeClass("search-show");
  
            update_sidebar_nicescroll();
          }
        });
  
        update_sidebar_nicescroll();
  
        if (now_layout_class == 'layout-3') {
          let nav_second_classes = $(".navbar-secondary").attr('class'),
            nav_second = $(".navbar-secondary");
  
          nav_second.attr('data-nav-classes', nav_second_classes);
          nav_second.removeAttr('class');
          nav_second.addClass('main-sidebar');
  
          let main_sidebar = $(".main-sidebar");
          main_sidebar.find('.container').addClass('sidebar-wrapper').removeClass('container');
          main_sidebar.find('.navbar-nav').addClass('sidebar-menu').removeClass('navbar-nav');
          main_sidebar.find('.sidebar-menu .nav-item.dropdown.show a').click();
          main_sidebar.find('.sidebar-brand').remove();
          main_sidebar.find('.sidebar-menu').before($('<div>', {
            class: 'sidebar-brand'
          }).append(
            $('<a>', {
              href: $('.navbar-brand').attr('href'),
            }).html($('.navbar-brand').html())
          ));
          setTimeout(function () {
            sidebar_nicescroll = main_sidebar.niceScroll(sidebar_nicescroll_opts);
            sidebar_nicescroll = main_sidebar.getNiceScroll();
          }, 700);
  
          sidebar_dropdown();
          $(".main-wrapper").removeClass("container");
        }
      } else {
        $("body").removeClass("sidebar-gone sidebar-show");
        if (now_layout_class)
          $("body").addClass(now_layout_class);
  
        let nav_second_classes = $(".main-sidebar").attr('data-nav-classes'),
          nav_second = $(".main-sidebar");
  
        if (now_layout_class == 'layout-3' && nav_second.hasClass('main-sidebar')) {
          nav_second.find(".sidebar-menu li a.has-dropdown").off('click');
          nav_second.find('.sidebar-brand').remove();
          nav_second.removeAttr('class');
          nav_second.addClass(nav_second_classes);
  
          let main_sidebar = $(".navbar-secondary");
          main_sidebar.find('.sidebar-wrapper').addClass('container').removeClass('sidebar-wrapper');
          main_sidebar.find('.sidebar-menu').addClass('navbar-nav').removeClass('sidebar-menu');
          main_sidebar.find('.dropdown-menu').hide();
          main_sidebar.removeAttr('style');
          main_sidebar.removeAttr('tabindex');
          main_sidebar.removeAttr('data-nav-classes');
          $(".main-wrapper").addClass("container");
          // if(sidebar_nicescroll != null)
          //   sidebar_nicescroll.remove();
        } else if (now_layout_class == 'layout-2') {
          $("body").addClass("layout-2");
        } else {
          update_sidebar_nicescroll();
        }
      }
    }
    toggleLayout();
    $(window).resize(toggleLayout);
  
    $("[data-toggle='search']").click(function () {
      var body = $("body");
  
      if (body.hasClass('search-gone')) {
        body.addClass('search-gone');
        body.removeClass('search-show');
      } else {
        body.removeClass('search-gone');
        body.addClass('search-show');
      }
    });
  
    // tooltip
    $("[data-toggle='tooltip']").tooltip();
  
    // popover
    $('[data-toggle="popover"]').popover({
      container: 'body'
    });
  
    // Select2
    if (jQuery().select2) {
      $(".select2").select2();
    }
  
    // Selectric
    if (jQuery().selectric) {
      $(".selectric").selectric({
        disableOnMobile: false,
        nativeOnMobile: false
      });
    }
  
    $(".notification-toggle").dropdown();
    $(".notification-toggle").parent().on('shown.bs.dropdown', function () {
      $(".dropdown-list-icons").niceScroll({
        cursoropacitymin: .3,
        cursoropacitymax: .8,
        cursorwidth: 7
      });
    });
  
    $(".message-toggle").dropdown();
    $(".message-toggle").parent().on('shown.bs.dropdown', function () {
      $(".dropdown-list-message").niceScroll({
        cursoropacitymin: .3,
        cursoropacitymax: .8,
        cursorwidth: 7
      });
    });
  
    if ($(".chat-content").length) {
      $(".chat-content").niceScroll({
        cursoropacitymin: .3,
        cursoropacitymax: .8,
      });
      $('.chat-content').getNiceScroll(0).doScrollTop($('.chat-content').height());
    }
  
    if (jQuery().summernote) {
      $(".summernote").summernote({
        dialogsInBody: true,
        minHeight: 250,
      });
      $(".summernote-simple").summernote({
        dialogsInBody: true,
        minHeight: 150,
        toolbar: [
          ['style', ['bold', 'italic', 'underline', 'clear']],
          ['font', ['strikethrough']],
          ['para', ['paragraph']]
        ]
      });
    }
  
    if (window.CodeMirror) {
      $(".codeeditor").each(function () {
        let editor = CodeMirror.fromTextArea(this, {
          lineNumbers: true,
          theme: "duotone-dark",
          mode: 'javascript',
          height: 200
        });
        editor.setSize("100%", 200);
      });
    }
  
    // Follow function
    $('.follow-btn, .following-btn').each(function () {
      var me = $(this),
        follow_text = 'Follow',
        unfollow_text = 'Following';
  
      me.click(function () {
        if (me.hasClass('following-btn')) {
          me.removeClass('btn-danger');
          me.removeClass('following-btn');
          me.addClass('btn-primary');
          me.html(follow_text);
  
          eval(me.data('unfollow-action'));
        } else {
          me.removeClass('btn-primary');
          me.addClass('btn-danger');
          me.addClass('following-btn');
          me.html(unfollow_text);
  
          eval(me.data('follow-action'));
        }
        return false;
      });
    });
  
    // Dismiss function
    $("[data-dismiss]").each(function () {
      var me = $(this),
        target = me.data('dismiss');
  
      me.click(function () {
        $(target).fadeOut(function () {
          $(target).remove();
        });
        return false;
      });
    });
  
    // Collapsable
    $("[data-collapse]").each(function () {
      var me = $(this),
        target = me.data('collapse');
  
      me.click(function () {
        $(target).collapse('toggle');
        $(target).on('shown.bs.collapse', function (e) {
          e.stopPropagation();
          me.html('<i class="fas fa-minus"></i>');
        });
        $(target).on('hidden.bs.collapse', function (e) {
          e.stopPropagation();
          me.html('<i class="fas fa-plus"></i>');
        });
        return false;
      });
    });
  
    // Gallery
    $(".gallery .gallery-item").each(function () {
      var me = $(this);
  
      me.attr('href', me.data('image'));
      me.attr('title', me.data('title'));
      if (me.parent().hasClass('gallery-fw')) {
        me.css({
          height: me.parent().data('item-height'),
        });
        me.find('div').css({
          lineHeight: me.parent().data('item-height') + 'px'
        });
      }
      me.css({
        backgroundImage: 'url("' + me.data('image') + '")'
      });
    });
    if (jQuery().Chocolat) {
      $(".gallery").Chocolat({
        className: 'gallery',
        imageSelector: '.gallery-item',
      });
    }
  
    // Background
    $("[data-background]").each(function () {
      var me = $(this);
      me.css({
        backgroundImage: 'url(' + me.data('background') + ')'
      });
    });
  
    // Custom Tab
    $("[data-tab]").each(function () {
      var me = $(this);
  
      me.click(function () {
        if (!me.hasClass('active')) {
          var tab_group = $('[data-tab-group="' + me.data('tab') + '"]'),
            tab_group_active = $('[data-tab-group="' + me.data('tab') + '"].active'),
            target = $(me.attr('href')),
            links = $('[data-tab="' + me.data('tab') + '"]');
  
          links.removeClass('active');
          me.addClass('active');
          target.addClass('active');
          tab_group_active.removeClass('active');
        }
        return false;
      });
    });
  
    // Bootstrap 4 Validation
    $(".needs-validation").submit(function () {
      var form = $(this);
      if (form[0].checkValidity() === false) {
        event.preventDefault();
        event.stopPropagation();
      }
      form.addClass('was-validated');
    });
  
    // alert dismissible
    $(".alert-dismissible").each(function () {
      var me = $(this);
  
      me.find('.close').click(function () {
        me.alert('close');
      });
    });
  
    if ($('.main-navbar').length) {}
  
    // Image cropper
    $('[data-crop-image]').each(function (e) {
      $(this).css({
        overflow: 'hidden',
        position: 'relative',
        height: $(this).data('crop-image')
      });
    });
  
    // Slide Toggle
    $('[data-toggle-slide]').click(function () {
      let target = $(this).data('toggle-slide');
  
      $(target).slideToggle();
      return false;
    });
  
    // Dismiss modal
    $("[data-dismiss=modal]").click(function () {
      $(this).closest('.modal').modal('hide');
  
      return false;
    });
  
    // Width attribute
    $('[data-width]').each(function () {
      $(this).css({
        width: $(this).data('width')
      });
    });
  
    // Height attribute
    $('[data-height]').each(function () {
      $(this).css({
        height: $(this).data('height')
      });
    });
  
    // Chocolat
    if ($('.chocolat-parent').length && jQuery().Chocolat) {
      $('.chocolat-parent').Chocolat();
    }
  
    // Sortable card
    if ($('.sortable-card').length && jQuery().sortable) {
      $('.sortable-card').sortable({
        handle: '.card-header',
        opacity: .8,
        tolerance: 'pointer'
      });
    }
  
    // Daterangepicker
    if (jQuery().daterangepicker) {
      if ($(".datepicker").length) {
        $('.datepicker').daterangepicker({
          locale: {
            format: 'YYYY-MM-DD'
          },
          singleDatePicker: true,
        });
      }
      if ($(".datetimepicker").length) {
        $('.datetimepicker').daterangepicker({
          locale: {
            format: 'YYYY-MM-DD hh:mm'
          },
          singleDatePicker: true,
          timePicker: true,
          timePicker24Hour: true,
        });
      }
      if ($(".daterange").length) {
        $('.daterange').daterangepicker({
          locale: {
            format: 'YYYY-MM-DD'
          },
          drops: 'down',
          opens: 'right'
        });
      }
    }
  
    // Timepicker
    if (jQuery().timepicker && $(".timepicker").length) {
      $(".timepicker").timepicker({
        icons: {
          up: 'fas fa-chevron-up',
          down: 'fas fa-chevron-down'
        }
      });
    }
  });
  
  
  // stisla stisla.js
  "use strict";
  
  (function ($, window, i) {
    // Bootstrap 4 Modal
    $.fn.fireModal = function (options) {
      var options = $.extend({
        size: 'modal-md',
        center: false,
        animation: true,
        title: 'Modal Title',
        closeButton: true,
        header: true,
        bodyClass: '',
        footerClass: '',
        body: '',
        buttons: [],
        autoFocus: true,
        removeOnDismiss: false,
        created: function () {},
        appended: function () {},
        onFormSubmit: function () {},
        modal: {}
      }, options);
  
      this.each(function () {
        i++;
        var id = 'fire-modal-' + i,
          trigger_class = 'trigger--' + id,
          trigger_button = $('.' + trigger_class);
  
        $(this).addClass(trigger_class);
  
        // Get modal body
        let body = options.body;
  
        if (typeof body == 'object') {
          if (body.length) {
            let part = body;
            body = body.removeAttr('id').clone().removeClass('modal-part');
            part.remove();
          } else {
            body = '<div class="text-danger">Modal part element not found!</div>';
          }
        }
  
        // Modal base template
        var modal_template = '   <div class="modal' + (options.animation == true ? ' fade' : '') + '" tabindex="-1" role="dialog" id="' + id + '">  ' +
          '     <div class="modal-dialog ' + options.size + (options.center ? ' modal-dialog-centered' : '') + '" role="document">  ' +
          '       <div class="modal-content">  ' +
          ((options.header == true) ?
            '         <div class="modal-header">  ' +
            '           <h5 class="modal-title">' + options.title + '</h5>  ' +
            ((options.closeButton == true) ?
              '           <button type="button" class="close" data-dismiss="modal" aria-label="Close">  ' +
              '             <span aria-hidden="true">&times;</span>  ' +
              '           </button>  ' :
              '') +
            '         </div>  ' :
            '') +
          '         <div class="modal-body">  ' +
          '         </div>  ' +
          (options.buttons.length > 0 ?
            '         <div class="modal-footer">  ' +
            '         </div>  ' :
            '') +
          '       </div>  ' +
          '     </div>  ' +
          '  </div>  ';
  
        // Convert modal to object
        var modal_template = $(modal_template);
  
        // Start creating buttons from 'buttons' option
        var this_button;
        options.buttons.forEach(function (item) {
          // get option 'id'
          let id = "id" in item ? item.id : '';
  
          // Button template
          this_button = '<button type="' + ("submit" in item && item.submit == true ? 'submit' : 'button') + '" class="' + item.class + '" id="' + id + '">' + item.text + '</button>';
  
          // add click event to the button
          this_button = $(this_button).off('click').on("click", function () {
            // execute function from 'handler' option
            item.handler.call(this, modal_template);
          });
          // append generated buttons to the modal footer
          $(modal_template).find('.modal-footer').append(this_button);
        });
  
        // append a given body to the modal
        $(modal_template).find('.modal-body').append(body);
  
        // add additional body class
        if (options.bodyClass) $(modal_template).find('.modal-body').addClass(options.bodyClass);
  
        // add footer body class
        if (options.footerClass) $(modal_template).find('.modal-footer').addClass(options.footerClass);
  
        // execute 'created' callback
        options.created.call(this, modal_template, options);
  
        // modal form and submit form button
        let modal_form = $(modal_template).find('.modal-body form'),
          form_submit_btn = modal_template.find('button[type=submit]');
  
        // append generated modal to the body
        $("body").append(modal_template);
  
        // execute 'appended' callback
        options.appended.call(this, $('#' + id), modal_form, options);
  
        // if modal contains form elements
        if (modal_form.length) {
          // if `autoFocus` option is true
          if (options.autoFocus) {
            // when modal is shown
            $(modal_template).on('shown.bs.modal', function () {
              // if type of `autoFocus` option is `boolean`
              if (typeof options.autoFocus == 'boolean')
                modal_form.find('input:eq(0)').focus(); // the first input element will be focused
              // if type of `autoFocus` option is `string` and `autoFocus` option is an HTML element
              else if (typeof options.autoFocus == 'string' && modal_form.find(options.autoFocus).length)
                modal_form.find(options.autoFocus).focus(); // find elements and focus on that
            });
          }
  
          // form object
          let form_object = {
            startProgress: function () {
              modal_template.addClass('modal-progress');
            },
            stopProgress: function () {
              modal_template.removeClass('modal-progress');
            }
          };
  
          // if form is not contains button element
          if (!modal_form.find('button').length) $(modal_form).append('<button class="d-none" id="' + id + '-submit"></button>');
  
          // add click event
          form_submit_btn.click(function () {
            modal_form.submit();
          });
  
          // add submit event
          modal_form.submit(function (e) {
            // start form progress
            form_object.startProgress();
  
            // execute `onFormSubmit` callback
            options.onFormSubmit.call(this, modal_template, e, form_object);
          });
        }
  
        $(document).on("click", '.' + trigger_class, function () {
          let modal = $('#' + id).modal(options.modal);
  
          if (options.removeOnDismiss) {
            modal.on('hidden.bs.modal', function () {
              modal.remove();
            });
          }
  
          return false;
        });
      });
    }
  
    // Bootstrap Modal Destroyer
    $.destroyModal = function (modal) {
      modal.modal('hide');
      modal.on('hidden.bs.modal', function () {});
    }
  
    // Card Progress Controller
    $.cardProgress = function (card, options) {
      var options = $.extend({
        dismiss: false,
        dismissText: 'Cancel',
        spinner: true,
        onDismiss: function () {}
      }, options);
  
      var me = $(card);
  
      me.addClass('card-progress');
      if (options.spinner == false) {
        me.addClass('remove-spinner');
      }
  
      if (options.dismiss == true) {
        var btn_dismiss = '<a class="btn btn-danger card-progress-dismiss">' + options.dismissText + '</a>';
        btn_dismiss = $(btn_dismiss).off('click').on('click', function () {
          me.removeClass('card-progress');
          me.find('.card-progress-dismiss').remove();
          options.onDismiss.call(this, me);
        });
        me.append(btn_dismiss);
      }
  
      return {
        dismiss: function (dismissed) {
          $.cardProgressDismiss(me, dismissed);
        }
      };
    }
  
    $.cardProgressDismiss = function (card, dismissed) {
      var me = $(card);
      me.removeClass('card-progress');
      me.find('.card-progress-dismiss').remove();
      if (dismissed)
        dismissed.call(this, me);
    }
  
    $.chatCtrl = function (element, chat) {
      var chat = $.extend({
        position: 'chat-right',
        text: '',
        time: moment(new Date().toISOString()).format('hh:mm'),
        picture: '',
        type: 'text', // or typing
        timeout: 0,
        onShow: function () {}
      }, chat);
  
      var target = $(element),
        element = '<div class="chat-item ' + chat.position + '" style="display:none">' +
        '<img src="' + chat.picture + '">' +
        '<div class="chat-details">' +
        '<div class="chat-text">' + chat.text + '</div>' +
        '<div class="chat-time">' + chat.time + '</div>' +
        '</div>' +
        '</div>',
        typing_element = '<div class="chat-item chat-left chat-typing" style="display:none">' +
        '<img src="' + chat.picture + '">' +
        '<div class="chat-details">' +
        '<div class="chat-text"></div>' +
        '</div>' +
        '</div>';
  
      var append_element = element;
      if (chat.type == 'typing') {
        append_element = typing_element;
      }
  
      if (chat.timeout > 0) {
        setTimeout(function () {
          target.find('.chat-content').append($(append_element).fadeIn());
        }, chat.timeout);
      } else {
        target.find('.chat-content').append($(append_element).fadeIn());
      }
  
      var target_height = 0;
      target.find('.chat-content .chat-item').each(function () {
        target_height += $(this).outerHeight();
      });
      setTimeout(function () {
        target.find('.chat-content').scrollTop(target_height, -1);
      }, 100);
      chat.onShow.call(this, append_element);
    }
  })(jQuery, this, 0);