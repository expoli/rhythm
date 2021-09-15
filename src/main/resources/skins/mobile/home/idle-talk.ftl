<#--

    Symphony - A modern community (forum/BBS/SNS/blog) platform written in Java.
    Copyright (C) 2012-present, b3log.org

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>.

-->
<#include "../macro-head.ftl">
<!DOCTYPE html>
<html>
    <head>
        <@head title="龙门阵 - ${symphonyLabel}">
        </@head>
    </head>
    <body>
        <#include "../header.ftl">
        <div class="main">
            <div class="wrapper">
                <div class="fn-hr10"></div>
                <div class="module">
                    <div class="module-header">
                        <h2>龙门阵</h2>
                        <div style="font-size: 12px;line-height: 18px; padding: 15px">
                            阁下可在「摸鱼派」派中摆「龙门阵」输送密信，全程保密托送，陆个时辰对方未读，将会秘密销毁；阅后即焚。<br>
                            —— 即便是这摸鱼派掌门人，也是毫无窃信之法。<br>
                            顺便偷偷告诉您：<b>要摆出这「龙门阵」，您要花费 5 两积分</b>。
                        </div>
                        <div>
                            <button onclick="IdleTalk.expand()" class="green">摆「龙门阵」</button>
                        </div>
                    </div>
                    <div id="sendMessageWindow" style="height: 150px;display: none;">
                        <div style="height: 130px;">
                            <input id="userForm" placeholder="收件人用户名" style="behavior:url(#default#savehistory);width: calc(100% - 43px); height: 20px; border: 1px solid #eee; padding: 20px">
                            <input id="themeForm" placeholder="信柬主题（50字以内）" style="behavior:url(#default#savehistory);width: calc(100% - 43px); height: 20px; border: 1px solid #eee; padding: 20px">
                        </div>
                        <div id="messageContent"></div>
                        <div>
                            <button class="green fn-right" style="margin-top: 15px;" onclick="IdleTalk.send()">确定发信</button>
                        </div>
                    </div>
                    <h3 id="title" style="padding: 20px 0 20px 0">收到的信柬</h3>
                    <div class="module-panel" style="padding-top: 15px;">
                        <ul id="received" class="module-list">
                            <#if meReceived?? && (meReceived?size > 0)>
                                <#list meReceived as receivedMessage>
                                    <li id="${receivedMessage.mapId}">
                                        <div class='fn-flex'>
                                            <a href="${servePath}/member/${receivedMessage.fromUserName}">
                                                <div class="avatar tooltipped tooltipped-ne"
                                                     aria-label="${receivedMessage.fromUserName}"
                                                     style="background-image:url('${receivedMessage.fromUserAvatar}')"></div>
                                            </a>
                                            <div class="fn-flex-1">
                                                <h2>
                                                    <a href="${servePath}/member/${receivedMessage.fromUserName}">来自「${receivedMessage.fromUserName}」的龙门阵密信</a>
                                                    <button class="red fn-right" onclick="IdleTalk.seek('${receivedMessage.mapId}')">查看并销毁</button>
                                                </h2>
                                                <span class="ft-fade vditor-reset">
                                                <#assign thisDate=receivedMessage.mapId?number?number_to_datetime>
                                                    ${thisDate?string("yyyy年MM月dd日 HH:mm:ss")} · 主题：${receivedMessage.theme}
                                            </span>
                                            </div>
                                        </div>
                                    </li>
                                </#list>
                            </#if>
                        </ul>
                    </div>
                    <h3 style="padding: 20px 0 20px 0">发出但未被阅读的密信</h3>
                    <div class="module-panel" style="padding-top: 15px;">
                        <ul id="sent" class="module-list">
                            <#if meSent?? && (meSent?size > 0)>
                                <#list meSent as sentMessage>
                                    <li id="${sentMessage.mapId}">
                                        <div class='fn-flex'>
                                            <a href="${servePath}/member/${sentMessage.toUserName}">
                                                <div class="avatar tooltipped tooltipped-ne"
                                                     aria-label="${sentMessage.toUserName}"
                                                     style="background-image:url('${sentMessage.toUserAvatar}')"></div>
                                            </a>
                                            <div class="fn-flex-1">
                                                <h2>
                                                    <a href="${servePath}/member/${sentMessage.toUserName}">发送给「${sentMessage.toUserName}」的龙门阵密信</a>
                                                    <button class="btn fn-right" style="margin-left: 10px" onclick="IdleTalk.revoke('${sentMessage.mapId}')">撤回</button>
                                                </h2>
                                                <span class="ft-fade vditor-reset">
                                                <#assign thisDate=sentMessage.mapId?number?number_to_datetime>
                                                    ${thisDate?string("yyyy年MM月dd日 HH:mm:ss")} · 主题：${sentMessage.theme}
                                            </span>
                                            </div>
                                        </div>
                                    </li>
                                </#list>
                            </#if>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <#include "../footer.ftl">
    </body>
</html>
<script src="${staticServePath}/js/idle-talk${miniPostfix}.js?${staticResourceVersion}"></script>
<script src="${staticServePath}/js/channel${miniPostfix}.js?${staticResourceVersion}"></script>
<script>
    // Init [IdleTalk] channel
    IdleTalkChannel.init("${wsScheme}://${serverHost}:${serverPort}${contextPath}/idle-talk-channel");
</script>
