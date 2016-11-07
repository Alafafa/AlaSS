{include file='user/main.tpl'}

<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
        <h1>
            用户中心
            <small>User Center</small>
        </h1>
    </section>

    <!-- Main content -->
    <section class="content">
        <!-- START PROGRESS BARS -->
        <div class="row">
            <div class="col-md-6">
                <div class="box box-primary">
                    <div class="box-header">
                        <i class="fa fa-bullhorn"></i>

                        <h3 class="box-title">基本信息</h3>
                    </div>
                    <!-- /.box-header -->
                    <div class="box-body">
                        {$msg}
                    </div>
                    <!-- /.box-body -->
                    <dl class="dl-horizontal">
                        <dt>用户等级</dt>
                        <dd>
	                        {if $user->type == 0}
	                        	测试用户
	                        {elseif $user->type == 1}
	                        	高级用户
	                        {elseif $user->type == 2}
	                        	中级用户
	                        {elseif $user->type == 3}
	                        	初级用户
	                        {elseif $user->type == 9}
	                        	友情用户
	                        {else}
	                        	未知用户
	                        {/if}
                        </td>
                        <dt>流量配额</dt>
                        <dd>{$user->enableTraffic()}</dd>
                        <dt>注册时间</dt>
                        <dd>{$user->reg_date}</dd>
                        
	                    {if $user->type != 0}
                        <dt>服务生效时间</dt>
                        <dd>{$user->valid_time}</dd>
                        <dt>服务到期时间</dt>
                        <dd>{$user->expire_time}</dd>
                        {else}
                        <dt>服务生效时间</dt>
                        <dd>{$user->reg_date}</dd>
                        <dt>服务到期时间</dt>
                        <dd>2099-12-31 23:59:59</dd>
                        {/if}
                    </dl>
                </div>
                <!-- /.box -->
            </div>
            <!-- /.col (right) -->

            <div class="col-md-6">
                <div class="box box-primary">
                    <div class="box-header">
                        <i class="fa fa-exchange"></i>
                        <h3 class="box-title">流量使用情况</h3>
                    </div>
                    <!-- /.box-header -->
                    <div class="box-body">
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="progress progress-striped">
                                    <div class="progress-bar progress-bar-primary" role="progressbar" aria-valuenow="40"
                                         aria-valuemin="0" aria-valuemax="100"
                                         style="width: {$user->trafficUsagePercent()}%">
                                        <span class="sr-only">Transfer</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <dl class="dl-horizontal">
                        	{if $user->type == 0}
                        	<dt>总流量(一次性)</dt>
                        	{else}
                            <dt>总流量(每月)</dt>
                            {/if}
                            <dd>{$user->enableTraffic()}</dd>
                            <dt>已用流量</dt>
                            <dd>{$user->usedTraffic()}</dd>
                            <dt>剩余流量</dt>
                            <dd>{$user->unusedTraffic()}</dd>
                        </dl>
                    </div>
                    <!-- /.box-body -->
                </div>
                <!-- /.box -->
            </div>
            <!-- /.col (left) -->

            <div class="col-md-6">
                <div class="box box-primary">
                    <div class="box-header">
                        <i class="fa fa-pencil"></i>

                        <h3 class="box-title">签到获取流量</h3>
                    </div>
                    <!-- /.box-header -->
                    <div class="box-body">
                        <p>每{$config['checkinTime']}小时可以签到一次。</p>

                        <p>上次签到时间：<code>{$user->lastCheckInTime()}</code></p>
                        <p style='height:6px'></p>
                        {if $user->isAbleToCheckin() }
                            <p id="checkin-btn">
                                <button id="checkin" class="btn btn-success btn-flat">签到</button>
                            </p>
                        {else}
                            <p>
                            	<a class="btn btn-success btn-flat disabled" href="#">不能签到</a>
                            </p>
                        {/if}
                        <p id="checkin-msg"></p>
                    </div>
                    <!-- /.box-body -->
                </div>
                <!-- /.box -->
            </div>
            <!-- /.col (right) -->

            <div class="col-md-6">
                <div class="box box-primary">
                    <div class="box-header">
                        <i class="fa  fa-paper-plane"></i>

                        <h3 class="box-title">连接信息</h3>
                    </div>
                    <!-- /.box-header -->
                    <div class="box-body">
                        <dl class="dl-horizontal">
                        	{if $user->isAbleToChgNode() }
                            <dt>服务器</dt>
                            <dd>不限</dd>
                        	{else}
                            <dt>服务器地址</dt>
                            <dd>
                            	{$node->server} 
                            	&nbsp;
                            	<a href="./user/node/{$node->id}"><span class="badge bg-blue">详细</span></a>
                            </dd>
                        	{/if}
                            <dt>连接端口</dt>
                            <dd>{$user->port}</dd>
                            <dt>加密密码</dt>
                            <dd>{$user->passwd}</dd>
                            <dt>加密方式</dt>
                            <dd>{$user->method}</dd>
                            <dt>上次使用</dt>
                            <dd>{$user->lastSsTime()}</dd>
                        </dl>
                    </div>
                    <!-- /.box-body -->
                </div>
                <!-- /.box -->
            </div>
            <!-- /.col (right) -->
        </div>
        <!-- /.row --><!-- END PROGRESS BARS -->
    </section>
    <!-- /.content -->
</div><!-- /.content-wrapper -->

<script>
    $(document).ready(function () {
        $("#checkin").click(function () {
            $.ajax({
                type: "POST",
                url: "/user/checkin",
                dataType: "json",
                success: function (data) {
                    $("#checkin-msg").html(data.msg);
                    $("#checkin-btn").hide();
                },
                error: function (jqXHR) {
                    alert("发生错误：" + jqXHR.status);
                }
            })
        })
    })
</script>


{include file='user/footer.tpl'}