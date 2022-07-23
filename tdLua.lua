#!/usr/bin/env lua5.3
-- version 1.3
-- github.com/tdLua
local tdLua_function, function_core, update_functions, tdLua_timer = {}, {}, {}, {}
local tdLua = {
  get_update = true,
  logo = [[
 _     _   _    _       ____  ____      _     __  __
| |   | | | |  / \     / ___||  _ \    / \   |  \/  |
| |   | | | | / _ \   | |  _ | |_) |  / _ \  | |\/| |
| |___| |_| |/ ___ \  | |_| ||  _ <  / ___ \ | |  | |
|_____|\___//_/   \_\  \____||_| \_\/_/   \_\|_|  |_|

VERSION : 1.3 / BETA]],
tdLua_helper = {
      ['editInlineMessageText'] = ' function > app.editInlineMessageText(inline_message_id, input_message_content, reply_markup)',
      ['match'] = ' function > app.match(table)[value]',
      ['base64_encode'] = ' function > app.base64_encode(str)',
      ['base64_decode'] = ' function > app.base64_decode(str)',
      ['number_format'] = ' function > app.number_format(number)',
      ['secToClock'] = ' function > app.secToClock(seconds)',
      ['in_array'] = ' function > app.in_array(table, value)',
      ['add_events'] = ' function > app.add_events(def,filters)',
      ['vardump'] = ' function > app.vardump(input)',
      ['set_timer'] = ' function > app.set_timer(seconds, def, argv)',
      ['get_timer'] = ' function > app.get_timer(timer_id)',
      ['cancel_timer'] = ' function > app.cancel_timer(timer_id)',
      ['exists'] = ' function > app.exists(file)',
      ['logOut'] = ' function > app.logOut()',
      ['getPasswordState'] = ' function > app.getPasswordState()',
      ['setPassword'] = ' function > app.setPassword(old_password, new_password, new_hint, set_recovery_email_address, new_recovery_email_address)',
      ['getRecoveryEmailAddress'] = ' function > app.getRecoveryEmailAddress(password)',
      ['setRecoveryEmailAddress'] = ' function > app.setRecoveryEmailAddress(password, new_recovery_email_address)',
      ['requestPasswordRecovery'] = ' function > app.requestPasswordRecovery()',
      ['recoverPassword'] = ' function > app.recoverPassword(recovery_code)',
      ['createTemporaryPassword'] = ' function > app.createTemporaryPassword(password, valid_for)',
      ['getTemporaryPasswordState'] = ' function > app.getTemporaryPasswordState()',
      ['getMe'] = ' function > app.getMe()',
      ['getUser'] = ' function > app.getUser(user_id)',
      ['getUserFullInfo'] = ' function > app.getUserFullInfo(user_id)',
      ['getBasicGroup'] = ' function > app.getBasicGroup(basic_group_id)',
      ['getBasicGroupFullInfo'] = ' function > app.getBasicGroupFullInfo(basic_group_id)',
      ['getSupergroup'] = ' function > app.getSupergroup(supergroup_id)',
      ['getSupergroupFullInfo'] = ' function > app.getSupergroupFullInfo(supergroup_id)',
      ['getSecretChat'] = ' function > app.getSecretChat(secret_chat_id)',
      ['getChat'] = ' function > app.getChat(chat_id)',
      ['getMessage'] = ' function > app.getMessage(chat_id, message_id)',
      ['getRepliedMessage'] = ' function > app.getRepliedMessage(chat_id, message_id)',
      ['getChatPinnedMessage'] = ' function > app.getChatPinnedMessage(chat_id)',
      ['getMessages'] = ' function > app.getMessages(chat_id, message_ids)',
      ['getFile'] = ' function > app.getFile(file_id)',
      ['getRemoteFile'] = ' function > app.getRemoteFile(remote_file_id, file_type)',
      ['getChats'] = ' function > app.getChats(chat_list, offset_order, offset_chat_id, limit)',
      ['searchPublicChat'] = ' function > app.searchPublicChat(username)',
      ['searchPublicChats'] = ' function > app.searchPublicChats(query)',
      ['searchChats'] = ' function > app.searchChats(query, limit)',
      ['checkChatUsername'] = ' function > app.checkChatUsername(chat_id, username)',
      ['searchChatsOnServer'] = ' function > app.searchChatsOnServer(query, limit)',
      ['clearRecentlyFoundChats'] = ' function > app.clearRecentlyFoundChats()',
      ['getTopChats'] = ' function > app.getTopChats(category, limit)',
      ['removeTopChat'] = ' function > app.removeTopChat(category, chat_id)',
      ['addRecentlyFoundChat'] = ' function > app.addRecentlyFoundChat(chat_id)',
      ['getCreatedPublicChats'] = ' function > app.getCreatedPublicChats()',
      ['setChatPermissions'] = ' function > app.setChatPermissions(chat_id, can_send_messages, can_send_media_messages, can_send_polls, can_send_other_messages, can_add_web_page_previews, can_change_info, can_invite_users, can_pin_messages)',
      ['removeRecentlyFoundChat'] = ' function > app.removeRecentlyFoundChat(chat_id)',
      ['getChatHistory'] = ' function > app.getChatHistory(chat_id, from_message_id, offset, limit, only_local)',
      ['getGroupsInCommon'] = ' function > app.getGroupsInCommon(user_id, offset_chat_id, limit)',
      ['searchMessages'] = ' function > app.searchMessages(query, offset_date, offset_chat_id, offset_message_id, limit)',
      ['searchChatMessages'] = ' function > app.searchChatMessages(chat_id, query, filter, sender_user_id, from_message_id, offset, limit)',
      ['searchSecretMessages'] = ' function > app.searchSecretMessages(chat_id, query, from_search_id, limit, filter)',
      ['deleteChatHistory'] = ' function > app.deleteChatHistory(chat_id, remove_from_chat_list)',
      ['searchCallMessages'] = ' function > app.searchCallMessages(from_message_id, limit, only_missed)',
      ['getChatMessageByDate'] = ' function > app.getChatMessageByDate(chat_id, date)',
      ['getPublicMessageLink'] = ' function > app.getPublicMessageLink(chat_id, message_id, for_album)',
      ['sendMessageAlbum'] = ' function > app.sendMessageAlbum(chat_id, reply_to_message_id, input_message_contents, disable_notification, from_background)',
      ['sendBotStartMessage'] = ' function > app.sendBotStartMessage(bot_user_id, chat_id, parameter)',
      ['sendInlineQueryResultMessage'] = ' function > app.sendInlineQueryResultMessage(chat_id, reply_to_message_id, disable_notification, from_background, query_id, result_id)',
      ['forwardMessages'] = ' function > app.forwardMessages(chat_id, from_chat_id, message_ids, disable_notification, from_background, as_album, send_copy, remove_caption)',
      ['sendChatSetTtlMessage'] = ' function > app.sendChatSetTtlMessage(chat_id, ttl)',
      ['sendChatScreenshotTakenNotification'] = ' function > app.sendChatScreenshotTakenNotification(chat_id)',
      ['deleteMessages'] = ' function > app.deleteMessages(chat_id, message_ids, revoke)',
      ['deleteChatMessagesFromUser'] = ' function > app.deleteChatMessagesFromUser(chat_id, user_id)',
      ['editMessageText'] = ' function > app.editMessageText(chat_id, message_id, text, parse_mode, disable_web_page_preview, clear_draft, reply_markup)',
      ['editMessageCaption'] = ' function > app.editMessageCaption(chat_id, message_id, caption, parse_mode, reply_markup)',
      ['getTextEntities'] = ' function > app.getTextEntities(text)',
      ['getFileMimeType'] = ' function > app.getFileMimeType(file_name)',
      ['getFileExtension'] = ' function > app.getFileExtension(mime_type)',
      ['getInlineQueryResults'] = ' function > app.getInlineQueryResults(bot_user_id, chat_id, latitude, longitude, query, offset)',
      ['getCallbackQueryAnswer'] = ' function > app.getCallbackQueryAnswer(chat_id, message_id, payload, data, game_short_name)',
      ['deleteChatReplyMarkup'] = ' function > app.deleteChatReplyMarkup(chat_id, message_id)',
      ['sendChatAction'] = ' function > app.sendChatAction(chat_id, action, progress)',
      ['openChat'] = ' function > app.openChat(chat_id)',
      ['closeChat'] = ' function > app.closeChat(chat_id)',
      ['viewMessages'] = ' function > app.viewMessages(chat_id, message_ids, force_read)',
      ['openMessageContent'] = ' function > app.openMessageContent(chat_id, message_id)',
      ['readAllChatMentions'] = ' function > app.readAllChatMentions(chat_id)',
      ['createPrivateChat'] = ' function > app.createPrivateChat(user_id, force)',
      ['createBasicGroupChat'] = ' function > app.createBasicGroupChat(basic_group_id, force)',
      ['createSupergroupChat'] = ' function > app.createSupergroupChat(supergroup_id, force)',
      ['createSecretChat'] = ' function > app.createSecretChat(secret_chat_id)',
      ['createNewBasicGroupChat'] = ' function > app.createNewBasicGroupChat(user_ids, title)',
      ['createNewSupergroupChat'] = ' function > app.createNewSupergroupChat(title, is_channel, description)',
      ['createNewSecretChat'] = ' function > app.createNewSecretChat(user_id)',
      ['upgradeBasicGroupChatToSupergroupChat'] = ' function > app.upgradeBasicGroupChatToSupergroupChat(chat_id)',
      ['setChatTitle'] = ' function > app.setChatTitle(chat_id, title)',
      ['setChatPhoto'] = ' function > app.setChatPhoto(chat_id, photo)',
      ['setChatDraftMessage'] = ' function > app.setChatDraftMessage(chat_id, reply_to_message_id, text, parse_mode, disable_web_page_preview, clear_draft)',
      ['toggleChatIsPinned'] = ' function > app.toggleChatIsPinned(chat_id, is_pinned)',
      ['setChatClientData'] = ' function > app.setChatClientData(chat_id, client_data)',
      ['addChatMember'] = ' function > app.addChatMember(chat_id, user_id, forward_limit)',
      ['addChatMembers'] = ' function > app.addChatMembers(chat_id, user_ids)',
      ['setChatMemberStatus'] = ' function > app.setChatMemberStatus(chat_id, user_id, status, right)',
      ['getChatMember'] = ' function > app.getChatMember(chat_id, user_id)',
      ['searchChatMembers'] = ' function > app.searchChatMembers(chat_id, query, limit)',
      ['getChatAdministrators'] = ' function > app.getChatAdministrators(chat_id)',
      ['setPinnedChats'] = ' function > app.setPinnedChats(chat_ids)',
      ['downloadFile'] = ' function > app.downloadFile(file_id, priority)',
      ['cancelDownloadFile'] = ' function > app.cancelDownloadFile(file_id, only_if_pending)',
      ['uploadFile'] = ' function > app.uploadFile(file, file_type, priority)',
      ['cancelUploadFile'] = ' function > app.cancelUploadFile(file_id)',
      ['deleteFile'] = ' function > app.deleteFile(file_id)',
      ['generateChatInviteLink'] = ' function > app.generateChatInviteLink(chat_id)',
      ['checkChatInviteLink'] = ' function > app.checkChatInviteLink(invite_link)',
      ['joinChatByInviteLink'] = ' function > app.joinChatByInviteLink(invite_link)',
      ['joinChatByUsernam'] = ' function > app.joinChatByUsernam(username)',
      ['createCall'] = ' function > app.createCall(user_id, udp_p2p, udp_reflector, min_layer, max_layer)',
      ['acceptCall'] = ' function > app.acceptCall(call_id, udp_p2p, udp_reflector, min_layer, max_layer)',
      ['blockUser'] = ' function > app.blockUser(user_id)',
      ['unblockUser'] = ' function > app.unblockUser(user_id)',
      ['getBlockedUsers'] = ' function > app.getBlockedUsers(offset, limit)',
      ['importContacts'] = ' function > app.importContacts(contacts)',
      ['searchContacts'] = ' function > app.searchContacts(query, limit)',
      ['removeContacts'] = ' function > app.removeContacts(user_ids)',
      ['getImportedContactCount'] = ' function > app.getImportedContactCount()',
      ['changeImportedContacts'] = ' function > app.changeImportedContacts(phone_number, first_name, last_name, user_id)',
      ['clearImportedContacts'] = ' function > app.clearImportedContacts()',
      ['getContacts'] = ' function > app.getContacts()',
      ['getUserProfilePhotos'] = ' function > app.getUserProfilePhotos(user_id, offset, limit)',
      ['getStickers'] = ' function > app.getStickers(emoji, limit)',
      ['searchStickers'] = ' function > app.searchStickers(emoji, limit)',
      ['getArchivedStickerSets'] = ' function > app.getArchivedStickerSets(is_masks, offset_sticker_set_id, limit)',
      ['getTrendingStickerSets'] = ' function > app.getTrendingStickerSets()',
      ['getAttachedStickerSets'] = ' function > app.getAttachedStickerSets(file_id)',
      ['getStickerSet'] = ' function > app.getStickerSet(set_id)',
      ['searchStickerSet'] = ' function > app.searchStickerSet(name)',
      ['searchInstalledStickerSets'] = ' function > app.searchInstalledStickerSets(is_masks, query, limit)',
      ['searchStickerSets'] = ' function > app.searchStickerSets(query)',
      ['changeStickerSet'] = ' function > app.changeStickerSet(set_id, is_installed, is_archived)',
      ['viewTrendingStickerSets'] = ' function > app.viewTrendingStickerSets(sticker_set_ids)',
      ['reorderInstalledStickerSets'] = ' function > app.reorderInstalledStickerSets(is_masks, sticker_set_ids)',
      ['getRecentStickers'] = ' function > app.getRecentStickers(is_attached)',
      ['addRecentSticker'] = ' function > app.addRecentSticker(is_attached, sticker)',
      ['clearRecentStickers'] = ' function > app.clearRecentStickers(is_attached)',
      ['getFavoriteStickers'] = ' function > app.getFavoriteStickers()',
      ['addFavoriteSticker'] = ' function > app.addFavoriteSticker(sticker)',
      ['removeFavoriteSticker'] = ' function > app.removeFavoriteSticker(sticker)',
      ['getStickerEmojis'] = ' function > app.getStickerEmojis(sticker)',
      ['getSavedAnimations'] = ' function > app.getSavedAnimations()',
      ['addSavedAnimation'] = ' function > app.addSavedAnimation(animation)',
      ['removeSavedAnimation'] = ' function > app.removeSavedAnimation(animation)',
      ['getRecentInlineBots'] = ' function > app.getRecentInlineBots()',
      ['searchHashtags'] = ' function > app.searchHashtags(prefix, limit)',
      ['removeRecentHashtag'] = ' function > app.removeRecentHashtag(hashtag)',
      ['getWebPagePreview'] = ' function > app.getWebPagePreview(text)',
      ['getWebPageInstantView'] = ' function > app.getWebPageInstantView(url, force_full)',
      ['getNotificationSettings'] = ' function > app.getNotificationSettings(scope, chat_id)',
      ['setNotificationSettings'] = ' function > app.setNotificationSettings(scope, chat_id, mute_for, sound, show_preview)',
      ['resetAllNotificationSettings'] = ' function > app.resetAllNotificationSettings()',
      ['setProfilePhoto'] = ' function > app.setProfilePhoto(photo)',
      ['deleteProfilePhoto'] = ' function > app.deleteProfilePhoto(profile_photo_id)',
      ['setName'] = ' function > app.setName(first_name, last_name)',
      ['setBio'] = ' function > app.setBio(bio)',
      ['setUsername'] = ' function > app.setUsername(username)',
      ['getActiveSessions'] = ' function > app.getActiveSessions()',
      ['terminateAllOtherSessions'] = ' function > app.terminateAllOtherSessions()',
      ['terminateSession'] = ' function > app.terminateSession(session_id)',
      ['toggleBasicGroupAdministrators'] = ' function > app.toggleBasicGroupAdministrators(basic_group_id, everyone_is_administrator)',
      ['setSupergroupUsername'] = ' function > app.setSupergroupUsername(supergroup_id, username)',
      ['setSupergroupStickerSet'] = ' function > app.setSupergroupStickerSet(supergroup_id, sticker_set_id)',
      ['toggleSupergroupInvites'] = ' function > app.toggleSupergroupInvites(supergroup_id, anyone_can_invite)',
      ['toggleSupergroupSignMessages'] = ' function > app.toggleSupergroupSignMessages(supergroup_id, sign_messages)',
      ['toggleSupergroupIsAllHistoryAvailable'] = ' function > app.toggleSupergroupIsAllHistoryAvailable(supergroup_id, is_all_history_available)',
      ['setChatDescription'] = ' function > app.setChatDescription(supergroup_id, description)',
      ['pinChatMessage'] = ' function > app.pinChatMessage(supergroup_id, message_id, disable_notification)',
      ['unpinChatMessage'] = ' function > app.unpinChatMessage(supergroup_id)',
      ['reportSupergroupSpam'] = ' function > app.reportSupergroupSpam(supergroup_id, user_id, message_ids)',
      ['getSupergroupMembers'] = ' function > app.getSupergroupMembers(supergroup_id, filter, query, offset, limit)',
      ['deleteSupergroup'] = ' function > app.deleteSupergroup(supergroup_id)',
      ['closeSecretChat'] = ' function > app.closeSecretChat(secret_chat_id)',
      ['getChatEventLog'] = ' function > app.getChatEventLog(chat_id, query, from_event_id, limit, filters, user_ids)',
      ['getSavedOrderInfo'] = ' function > app.getSavedOrderInfo()',
      ['deleteSavedOrderInfo'] = ' function > app.deleteSavedOrderInfo()',
      ['deleteSavedCredentials'] = ' function > app.deleteSavedCredentials()',
      ['getSupportUser'] = ' function > app.getSupportUser()',
      ['getWallpapers'] = ' function > app.getWallpapers()',
      ['setUserPrivacySettingRules'] = ' function > app.setUserPrivacySettingRules(setting, rules, allowed_user_ids, restricted_user_ids)',
      ['getUserPrivacySettingRules'] = ' function > app.getUserPrivacySettingRules(setting)',
      ['getOption'] = ' function > app.getOption(name)',
      ['setOption'] = ' function > app.setOption(name, option_value, value)',
      ['setAccountTtl'] = ' function > app.setAccountTtl(ttl)',
      ['getAccountTtl'] = ' function > app.getAccountTtl()',
      ['deleteAccount'] = ' function > app.deleteAccount(reason)',
      ['getChatReportSpamState'] = ' function > app.getChatReportSpamState(chat_id)',
      ['reportChat'] = ' function > app.reportChat(chat_id, reason, text, message_ids)',
      ['getStorageStatistics'] = ' function > app.getStorageStatistics(chat_limit)',
      ['getStorageStatisticsFast'] = ' function > app.getStorageStatisticsFast()',
      ['optimizeStorage'] = ' function > app.optimizeStorage(size, ttl, count, immunity_delay, file_type, chat_ids, exclude_chat_ids, chat_limit)',
      ['setNetworkType'] = ' function > app.setNetworkType(type)',
      ['getNetworkStatistics'] = ' function > app.getNetworkStatistics(only_current)',
      ['addNetworkStatistics'] = ' function > app.addNetworkStatistics(entry, file_type, network_type, sent_bytes, received_bytes, duration)',
      ['resetNetworkStatistics'] = ' function > app.resetNetworkStatistics()',
      ['getCountryCode'] = ' function > app.getCountryCode()',
      ['getInviteText'] = ' function > app.getInviteText()',
      ['getTermsOfService'] = ' function > app.getTermsOfService()',
      ['sendText'] = ' function > app.sendText(chat_id, reply_to_message_id, text, parse_mode, disable_web_page_preview, clear_draft, disable_notification, from_background, reply_markup)',
      ['sendAnimation'] = ' function > app.sendAnimation(chat_id, reply_to_message_id, animation, caption, parse_mode, duration, width, height, thumbnail, thumb_width, thumb_height, disable_notification, from_background, reply_markup)',
      ['sendAudio'] = ' function > app.sendAudio(chat_id, reply_to_message_id, audio, caption, parse_mode, duration, title, performer, thumbnail, thumb_width, thumb_height, disable_notification, from_background, reply_markup)',
      ['sendDocument'] = ' function > app.sendDocument(chat_id, reply_to_message_id, document, caption, parse_mode, thumbnail, thumb_width, thumb_height, disable_notification, from_background, reply_markup)',
      ['sendPhoto'] = ' function > app.sendPhoto(chat_id, reply_to_message_id, photo, caption, parse_mode, added_sticker_file_ids, width, height, ttl, thumbnail, thumb_width, thumb_height, disable_notification, from_background, reply_markup)',
      ['sendSticker'] = ' function > app.sendSticker(chat_id, reply_to_message_id, sticker, width, height, disable_notification, thumbnail, thumb_width, thumb_height, from_background, reply_markup)',
      ['sendVideo'] = ' function > app.sendVideo(chat_id, reply_to_message_id, video, caption, parse_mode, added_sticker_file_ids, duration, width, height, ttl, thumbnail, thumb_width, thumb_height, disable_notification, from_background, reply_markup)',
      ['sendVideoNote'] = ' function > app.sendVideoNote(chat_id, reply_to_message_id, video_note, duration, length, thumbnail, thumb_width, thumb_height, disable_notification, from_background, reply_markup)',
      ['sendVoiceNote'] = ' function > app.sendVoiceNote(chat_id, reply_to_message_id, voice_note, caption, parse_mode, duration, waveform, disable_notification, from_background, reply_markup)',
      ['sendLocation'] = ' function > app.sendLocation(chat_id, reply_to_message_id, latitude, longitude, disable_notification, from_background, reply_markup)',
      ['sendVenue'] = ' function > app.sendVenue(chat_id, reply_to_message_id, latitude, longitude, title, address, provider, id, disable_notification, from_background, reply_markup)',
      ['sendContact'] = ' function > app.sendContact(chat_id, reply_to_message_id, phone_number, first_name, last_name, user_id, disable_notification, from_background, reply_markup)',
      ['sendInvoice'] = ' function > app.sendInvoice(chat_id, reply_to_message_id, invoice, title, description, photo_url, photo_size, photo_width, photo_height, payload, provider_token, provider_data, start_parameter, disable_notification, from_background, reply_markup)',
      ['sendForwarded'] = ' function > app.sendForwarded(chat_id, reply_to_message_id, from_chat_id, message_id, in_game_share, disable_notification, from_background, reply_markup)',
      ['sendPoll'] = ' function > app.sendPoll(chat_id, reply_to_message_id, question, options, pollType, is_anonymous, allow_multiple_answers)',
      ['addProxy'] = ' function > app.addProxy(proxy_type, server, port, username, password_secret, http_only)',
      ['enableProxy'] = ' function > app.enableProxy(proxy_id)',
      ['pingProxy'] = ' function > app.pingProxy(proxy_id)',
      ['disableProxy'] = ' function > app.disableProxy(proxy_id)',
      ['getProxies'] = ' function > app.getProxies()',
      ['answerCallbackQuery'] = ' function > app.answerCallbackQuery(callback_query_id, text, show_alert, url, cache_time)',
      ['leaveChat'] = ' function > app.leaveChat(chat_id)',
      ['replyMarkup'] = ' function > app.replyMarkup(input)',
      ['getPollVoters'] = ' function > app.getPollVoters(chat_id, message_id, option_id, offset, limit)',
      ['setPollAnswer'] = ' function > app.setPollAnswer(chat_id, message_id, option_ids)',
      ['len'] = ' function > app.len(value)',
      ['answerInlineQuery'] = ' function > app.answerInlineQuery(inline_query_id, results, next_offset, switch_pm_text, switch_pm_parameter, is_personal, cache_time)'
},
colors_key = {
  reset =      0,
  bright     = 1,
  dim        = 2,
  underline  = 4,
  blink      = 5,
  reverse    = 7,
  hidden     = 8,
  black     = 30,
  red       = 31,
  green     = 32,
  yellow    = 33,
  blue      = 34,
  magenta   = 35,
  cyan      = 36,
  white     = 37,
  blackbg   = 40,
  redbg     = 41,
  greenbg   = 42,
  yellowbg  = 43,
  bluebg    = 44,
  magentabg = 45,
  cyanbg    = 46,
  whitebg   = 47
},
  config = {
  }
}
local LuaGram = require('tdlua')
local client = LuaGram()
----------------------------------------------- tdLua core function
function function_core._CALL_(update)
  if update and type(update) == 'table' then
    for i = 0 , #update_functions do
      if not update_functions[i].filters then
        send_update = true
        update_message = update
      elseif update.tdLua and update_functions[i].filters and tdLua_function.in_array(update_functions[i].filters,  update.tdLua) then
        send_update = true
        update_message = update
      else
        send_update = false
      end
      if update_message and send_update and type(update_message) == 'table' then
        xpcall(update_functions[i].def, function_core.print_error, update_message)
      end
      update_message = nil
      send_update = nil
    end
  end
end
function function_core.change_table(input, send)
  if send then
    changes ={
      tdLua = string.reverse('epyt@')
    }
    rems = {
    }
  else
    changes = {
      _ = string.reverse('margaul'),
    }
    rems = {
      string.reverse('epyt@')
    }
  end
  if type(input) == 'table' then
    local res = {}
    for key,value in pairs(input) do
      for k, rem in pairs(rems) do
        if key == rem then
          value = nil
        end
      end
      local key = changes[key] or key
      if type(value) ~= 'table' then
        res[key] = value
      else
        res[key] = function_core.change_table(value, send)
      end
    end
    return res
  else
    return input
  end
end
function function_core.run_table(input)
  local to_original = function_core.change_table(input, true)
  local result = client:execute(to_original)
  if type(result) ~= 'table' then
    return nil
  else
    return function_core.change_table(result)
  end
end
function function_core.print_error(err)
  print(tdLua_function.colors('%{red}\27[5m bug in your script ! %{reset}\n\n%{red}'.. err))
end
function function_core.send_tdlib(input)
  local to_original = function_core.change_table(input, true)
  client:send(to_original)
end

function_core.send_tdlib{
  tdLua = 'getAuthorizationState'
}
LuaGram.setLogLevel(3)
LuaGram.setLogPath('/usr/lib/x86_64-linux-gnu/lua/5.3/.tdLua.log')
-----------------------------------------------tdLua_function
function tdLua_function.len(input)
  if type(input) == 'table' then
    size = 0
    for key,value in pairs(input) do
      size = size + 1
    end
    return size
  else
    size = tostring(input)
    return #size
  end
end
function tdLua_function.match(...)
  local val = {}
  for no,v in ipairs({...}) do
    val[v] = true
  end
  return val
end
function tdLua_function.secToClock(seconds)
  local seconds = tonumber(seconds)
  if seconds <= 0 then
    return {hours=00,mins=00,secs=00}
  else
    local hours = string.format("%02.f", math.floor(seconds / 3600));
    local mins = string.format("%02.f", math.floor(seconds / 60 - ( hours*60 ) ));
    local secs = string.format("%02.f", math.floor(seconds - hours * 3600 - mins * 60));
    return {hours=hours,mins=mins,secs=secs}
  end
end
function tdLua_function.number_format(num)
  local out = tonumber(num)
  while true do
    out,i= string.gsub(out,'^(-?%d+)(%d%d%d)', '%1,%2')
    if (i==0) then
      break
    end
  end
  return out
end
function tdLua_function.base64_encode(str)
	local Base ='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
	return ((str:gsub('.', function(x)
			local r,Base='',x:byte()
			for i=8,1,-1 do r=r..(Base%2^i-Base%2^(i-1)>0 and '1' or '0') end
			return r;
	end)..'0000'):gsub('%d%d%d?%d?%d?%d?', function(x)
			if (#x < 6) then return '' end
			local c=0
			for i=1,6 do c=c+(x:sub(i,i)=='1' and 2^(6-i) or 0) end
			return Base:sub(c+1,c+1)
	end)..({ '', '==', '=' })[#str%3+1])
end
function tdLua_function.base64_decode(str)
	local Base ='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
  str = string.gsub(str, '[^'..Base..'=]', '')
  return (str:gsub('.', function(x)
    if (x == '=') then
      return ''
    end
    local r,f='',(Base:find(x)-1)
    for i=6,1,-1 do r=r..(f%2^i-f%2^(i-1)>0 and '1' or '0') end
    return r;
  end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
    if (#x ~= 8) then
      return ''
    end
    local c=0
    for i=1,8 do c=c+(x:sub(i,i)=='1' and 2^(8-i) or 0) end
    return string.char(c)
  end))
end
function tdLua_function.exists(file)
   local ok, err, code = os.rename(file, file)
   if not ok then
      if code == 13 then
         return true
      end
   end
   return ok, err
end
function tdLua_function.in_array(table, value)
  for k,v in pairs(table) do
    if value == v then
      return true
    end
  end
  return false
end
function tdLua_function.colors(buffer)
  for keys in buffer:gmatch('%%{(.-)}') do
    buffer = string.gsub(buffer,'%%{'..keys..'}', '\27['..tdLua.colors_key[keys]..'m')
  end
  return buffer .. '\27[0m'
end
function tdLua_function.add_events(def,filters)
  if type(def) ~= 'function' then
    function_core.print_error('the add_events def must be a function !')
    return {
      tdLua = false,
    }
    elseif type(filters) ~= 'table' then
      function_core.print_error('the add_events filters must be a table !')
      return {
        tdLua = false,
      }
    else
      local function_id = #update_functions + 1
      update_functions[function_id] = {}
      update_functions[function_id].def = def
      update_functions[function_id].filters = filters
      return {
        tdLua = true,
      }
  end
end
function tdLua_function.help(def_name)
  if not def_name or def_name == '*' then
    local Counter = 0
    print(tdLua_function.colors('%{green} tdLua function name :%{reset} \n\n'))
    for function_name,example in pairs(tdLua.tdLua_helper) do
      if Counter % 2 == 0 then
        print(tdLua_function.colors(Counter..' - %{yellow}'..function_name..'%{reset}'))
      else
        print(Counter..' - '..function_name)
      end
      Counter = Counter + 1
    end
    print(tdLua_function.colors('\n\n%{green} > app.help(function_name)'))
  elseif def_name then
    for key,value in pairs(tdLua.tdLua_helper) do
      if string.lower(def_name) == string.lower(key) then
        print(tdLua_function.colors(' - %{yellow} '..value))
        return value
      end
    end
  else
    print(tdLua_function.colors(' - %{red} Function not found ! %{reset}'))
  end
end
function tdLua_function.vardump(input)
  local function vardump(value)
     if type(value) == 'table' then
        local dump = '{\n'
        for key,v in pairs(value) do
           if type(key) == 'number' then
             key = '['..key..']'
           elseif type(key) == 'string' and key:match('@') then
             key = '["'..key..'"]'
           end
           if type(v) == 'string' then
             v = "'" .. v .. "'"
           end
           dump = dump .. key .. ' = ' .. vardump(v) .. ',\n'
        end
        return dump .. '}'
     else
        return tostring(value)
     end
   end
  print(tdLua_function.colors('%{yellow} vardump : %{reset}\n\n%{green}'..vardump(input)))
  return vardump(input)
end
function tdLua_function.set_timer(seconds, def, argv)
  if type(seconds) ~= 'number' then
    return {
      tdLua = false,
      message = 'set_timer(int seconds, funtion def, table)'
    }
  elseif type(def) ~= 'function' then
    return {
      tdLua = false,
      message = 'set_timer(int seconds, funtion def, table)'
    }
  end
  tdLua_timer[#tdLua_timer + 1] = {
    def = def,
    argv = argv,
    run_in = os.time() + seconds
  }
  return {
    tdLua = true,
    run_in = os.time() + seconds,
    timer_id = #tdLua_timer
  }
end
function tdLua_function.get_timer(timer_id)
  local timer_data = tdLua_timer[timer_id]
  if timer_data then
    return {
      tdLua = true,
      run_in = timer_data.run_in,
      argv = timer_data.argv
    }
  else
    return {
      tdLua = false,
    }
  end
end
function tdLua_function.cancel_timer(timer_id)
  if tdLua_timer[timer_id] then
    table.remove(tdLua_timer,timer_id)
    return {
      tdLua = true
    }
  else
    return {
      tdLua = false
    }
  end
end

function tdLua_function.replyMarkup(input)
  if type(input.type) ~= 'string' then
    return nil
  end
  local _type = string.lower(input.type)
  if _type == 'inline' then
    local result = {
      tdLua = 'replyMarkupInlineKeyboard',
      rows = {
      }
    }
    for _, rows in pairs(input.data) do
      local new_id = #result.rows + 1
      result.rows[new_id] = {}
      for key, value in pairs(rows) do
        local rows_new_id = #result.rows[new_id] + 1
        if value.url and value.text then
          result.rows[new_id][rows_new_id] = {
            tdLua = 'inlineKeyboardButton',
            text = value.text,
            type = {
              tdLua = 'inlineKeyboardButtonTypeUrl',
              url = value.url
            }
          }
        elseif value.data and value.text then
            result.rows[new_id][rows_new_id] = {
              tdLua = 'inlineKeyboardButton',
              text = value.text,
              type = {
                data = tdLua_function.base64_encode(value.data), -- Base64 only
                tdLua = 'inlineKeyboardButtonTypeCallback',
              }
            }
          elseif value.forward_text and value.id and value.url and value.text then
            result.rows[new_id][rows_new_id] = {
              tdLua = 'inlineKeyboardButton',
              text = value.text,
              type = {
                id = value.id,
                url = value.url,
                forward_text = value.forward_text,
                tdLua = 'inlineKeyboardButtonTypeLoginUrl',
              }
            }
          elseif value.query and value.text then
            result.rows[new_id][rows_new_id] = {
              tdLua = 'inlineKeyboardButton',
              text = value.text,
              type = {
                query = value.query,
                tdLua = 'inlineKeyboardButtonTypeSwitchInline',
              }
            }
        end
      end
    end
    return result
  elseif _type == 'keyboard' then
    local result = {
      tdLua = 'replyMarkupShowKeyboard',
      resize_keyboard = input.resize,
      one_time = input.one_time,
      is_personal = input.is_personal,
      rows = {
      }
    }
    for _, rows in pairs(input.data) do
      local new_id = #result.rows + 1
      result.rows[new_id] = {}
      for key, value in pairs(rows) do
        local rows_new_id = #result.rows[new_id] + 1
        if type(value.type) == 'string' then
          value.type = string.lower(value.type)
          if value.type == 'requestlocation' and value.text then
            result.rows[new_id][rows_new_id] = {
              type = {
                tdLua = 'keyboardButtonTypeRequestLocation'
              },
              tdLua = 'keyboardButton',
              text = value.text
            }
          elseif value.type == 'requestphone' and value.text then
            result.rows[new_id][rows_new_id] = {
              type = {
                tdLua = 'keyboardButtonTypeRequestPhoneNumber'
              },
              tdLua = 'keyboardButton',
              text = value.text
            }
          elseif value.type == 'requestpoll' and value.text then
            result.rows[new_id][rows_new_id] = {
              type = {
                tdLua = 'keyboardButtonTypeRequestPoll',
                force_regular = value.force_regular,
                force_quiz = value.force_quiz
              },
              tdLua = 'keyboardButton',
              text = value.text
            }
          elseif value.type == 'text' and value.text then
            result.rows[new_id][rows_new_id] = {
              type = {
                tdLua = 'keyboardButtonTypeText'
              },
              tdLua = 'keyboardButton',
              text = value.text
            }
          end
        end
      end
    end
    return result
  elseif _type == 'forcereply' then
    return {
      tdLua = 'replyMarkupForceReply',
      is_personal = input.is_personal
    }
  elseif _type == 'remove' then
    return {
      tdLua = 'replyMarkupRemoveKeyboard',
      is_personal = input.is_personal
    }
  end
end
function tdLua_function.addProxy(proxy_type, server, port, username, password_secret, http_only)
  if type(proxy_type) ~= 'string' then
    return {
    tdLua = false
    }
  end
  local proxy_type = string.lower(proxy_type)
  if proxy_type == 'mtproto' then
    _type_ = {
      tdLua = 'proxyTypeMtproto',
      secret = password_secret
    }
  elseif proxy_Type == 'socks5' then
    _type_ = {
      tdLua = 'proxyTypeSocks5',
      username = username,
      password = password_secret
    }
  elseif proxy_Type == 'http' then
    _type_ = {
      tdLua = 'proxyTypeHttp',
      username = username,
      password = password_secret,
      http_only = http_only
    }
  else
    return {
      tdLua = false
    }
  end
  return function_core.run_table{
    tdLua = 'addProxy',
    server = server,
    port = port,
    type = _type_
  }
end
function tdLua_function.enableProxy(proxy_id)
  return function_core.run_table{
   tdLua = 'enableProxy',
    proxy_id = proxy_id
  }
end
function tdLua_function.pingProxy(proxy_id)
  return function_core.run_table{
   tdLua = 'pingProxy',
    proxy_id = proxy_id
  }
end
function tdLua_function.disableProxy(proxy_id)
  return function_core.run_table{
   tdLua = 'disableProxy',
    proxy_id = proxy_id
  }
end
function tdLua_function.getProxies()
  return function_core.run_table{
    tdLua = 'getProxies'
  }
end
function tdLua_function.getChatId(chat_id)
  local chat_id = tostring(chat_id)
  if chat_id:match('^-100') then
    return {
      id = string.sub(chat_id, 5),
      type = 'supergroup'
    }
  else
    local basicgroup_id = string.sub(chat_id, 2)
    return {
      id = string.sub(chat_id, 2),
      type = 'basicgroup'
    }
  end
end
function tdLua_function.getInputFile(file, conversion_str, expected_size)
  local str = tostring(file)
  if (conversion_str and expectedsize) then
    return {
      tdLua = 'inputFileGenerated',
      original_path = tostring(file),
      conversion = tostring(conversion_str),
      expected_size = expected_size
    }
  else
    if str:match('/') then
      return {
        tdLua = 'inputFileLocal',
        path = file
      }
    elseif str:match('^%d+$') then
      return {
        tdLua = 'inputFileId',
        id = file
      }
    else
      return {
        tdLua = 'inputFileRemote',
        id = file
      }
    end
  end
end
function tdLua_function.getParseMode(parse_mode)
  if parse_mode then
    local mode = parse_mode:lower()
    if mode == 'markdown' or mode == 'md' then
      return {
        tdLua = 'textParseModeMarkdown'
      }
    elseif mode == 'html' or mode == 'lg' then
      return {
        tdLua = 'textParseModeHTML'
      }
    end
  end
end
function tdLua_function.parseTextEntities(text, parse_mode)
  if type(parse_mode) == 'string' and string.lower(parse_mode) == 'lg' then
    for txt in text:gmatch('%%{(.-)}') do
      local _text, text_type = txt:match('(.*),(.*)')
      local txt = string.gsub(txt,'+','++')
      local text_type = string.gsub(text_type,' ','')
      if type(_text) == 'string' and type(text_type) == 'string' then
        for key, value in pairs({['<'] = '&lt;',['>'] = '&gt;'}) do
          _text = string.gsub(_text, key, value)
        end
        if (string.lower(text_type) == 'b' or string.lower(text_type) == 'i' or string.lower(text_type) == 'c') then
          local text_type = string.lower(text_type)
          local text_type = text_type == 'c' and 'code' or text_type
          text = string.gsub(text,'%%{'..txt..'}','<'..text_type..'>'.._text..'</'..text_type..'>')
        else
          if type(tonumber(text_type)) == 'number' then
            link = 'tg://user?id='..text_type
          else
            link = text_type
          end
          text = string.gsub(text, '%%{'..txt..'}', '<a href="'..link..'">'.._text..'</a>')
        end
      end
    end
  end
  return function_core.run_table{
    tdLua = 'parseTextEntities',
    text = tostring(text),
    parse_mode = tdLua_function.getParseMode(parse_mode)
  }
end
function tdLua_function.vectorize(table)
  if type(table) == 'table' then
    return table
  else
    return {
      table
    }
  end
end
function tdLua_function.setLimit(limit, num)
  local limit = tonumber(limit)
  local number = tonumber(num or limit)
  return (number >= limit) and limit or number
end
function tdLua_function.sendMessage(chat_id, reply_to_message_id, input_message_content, parse_mode, disable_notification, from_background, reply_markup)
  local tdLua_body, message = {
    tdLua = 'sendMessage',
    chat_id = chat_id,
    reply_to_message_id = reply_to_message_id or 0,
    disable_notification = disable_notification or 0,
    from_background = from_background or 1,
    reply_markup = reply_markup,
    input_message_content = input_message_content
  }, {}
  if input_message_content.text then
    text = input_message_content.text.text
  elseif input_message_content.caption then
    text = input_message_content.caption.text
  end
  if text then
    if parse_mode then
      local result = tdLua_function.parseTextEntities(text, parse_mode)
      if tdLua_body.input_message_content.text then
        tdLua_body.input_message_content.text = result
      else
        tdLua_body.input_message_content.caption = result
      end
      return function_core.run_table(tdLua_body)
    else
      while #text > 4096 do
        text = string.sub(text, 4096, #text)
        message[#message + 1] = text
      end
      message[#message + 1] = text
      for i = 1, #message do
        if input_message_content.text and input_message_content.text.text then
          tdLua_body.input_message_content.text.text = message[i]
        elseif input_message_content.caption and input_message_content.caption.text then
          tdLua_body.input_message_content.caption.text = message[i]
        end
        return function_core.run_table(tdLua_body)
      end
    end
  else
    return function_core.run_table(tdLua_body)
  end
end
function tdLua_function.logOut()
  return function_core.run_table{
    tdLua = 'logOut'
  }
end
function tdLua_function.getPasswordState()
  return function_core.run_table{
    tdLua = 'getPasswordState'
  }
end
function tdLua_function.setPassword(old_password, new_password, new_hint, set_recovery_email_address, new_recovery_email_address)
  return function_core.run_table{
    old_password = tostring(old_password),
    new_password = tostring(new_password),
    new_hint = tostring(new_hint),
    set_recovery_email_address = set_recovery_email_address,
    new_recovery_email_address = tostring(new_recovery_email_address)
  }
end
function tdLua_function.getRecoveryEmailAddress(password)
  return function_core.run_table{
    tdLua = 'getRecoveryEmailAddress',
    password = tostring(password)
  }
end
function tdLua_function.setRecoveryEmailAddress(password, new_recovery_email_address)
  return function_core.run_table{
    tdLua = 'setRecoveryEmailAddress',
    password = tostring(password),
    new_recovery_email_address = tostring(new_recovery_email_address)
  }
end
function tdLua_function.requestPasswordRecovery()
  return function_core.run_table{
    tdLua = 'requestPasswordRecovery'
  }
end
function tdLua_function.recoverPassword(recovery_code)
  return function_core.run_table{
    tdLua = 'recoverPassword',
    recovery_code = tostring(recovery_code)
  }
end
function tdLua_function.createTemporaryPassword(password, valid_for)
  local valid_for = valid_for > 86400 and 86400 or valid_for
  return function_core.run_table{
    tdLua = 'createTemporaryPassword',
    password = tostring(password),
    valid_for = valid_for
  }
end
function tdLua_function.getTemporaryPasswordState()
  return function_core.run_table{
    tdLua = 'getTemporaryPasswordState'
  }
end
function tdLua_function.getMe()
  return function_core.run_table{
    tdLua = 'getMe'
  }
end
function tdLua_function.getUser(user_id)
  return function_core.run_table{
    tdLua = 'getUser',
    user_id = user_id
  }
end
function tdLua_function.getUserFullInfo(user_id)
  return function_core.run_table{
    tdLua = 'getUserFullInfo',
    user_id = user_id
  }
end
function tdLua_function.getBasicGroup(basic_group_id)
  return function_core.run_table{
    tdLua = 'getBasicGroup',
    basic_group_id = tdLua_function.getChatId(basic_group_id).id
  }
end
function tdLua_function.getBasicGroupFullInfo(basic_group_id)
  return function_core.run_table{
    tdLua = 'getBasicGroupFullInfo',
    basic_group_id = tdLua_function.getChatId(basic_group_id).id
  }
end
function tdLua_function.getSupergroup(supergroup_id)
  return function_core.run_table{
    tdLua = 'getSupergroup',
    supergroup_id = tdLua_function.getChatId(supergroup_id).id
  }
end
function tdLua_function.getSupergroupFullInfo(supergroup_id)
  return function_core.run_table{
    tdLua = 'getSupergroupFullInfo',
    supergroup_id = tdLua_function.getChatId(supergroup_id).id
  }
end
function tdLua_function.getSecretChat(secret_chat_id)
  return function_core.run_table{
    tdLua = 'getSecretChat',
    secret_chat_id = secret_chat_id
  }
end
function tdLua_function.getChat(chat_id)
  return function_core.run_table{
    tdLua = 'getChat',
    chat_id = chat_id
  }
end
function tdLua_function.getMessage(chat_id, message_id)
  return function_core.run_table{
    tdLua = 'getMessage',
    chat_id = chat_id,
    message_id = message_id
  }
end
function tdLua_function.getRepliedMessage(chat_id, message_id)
  return function_core.run_table{
    tdLua = 'getRepliedMessage',
    chat_id = chat_id,
    message_id = message_id
  }
end
function tdLua_function.getChatPinnedMessage(chat_id)
  return function_core.run_table{
    tdLua = 'getChatPinnedMessage',
    chat_id = chat_id
  }
end
function tdLua_function.getMessages(chat_id, message_ids)
  return function_core.run_table{
    tdLua = 'getMessages',
    chat_id = chat_id,
    message_ids = tdLua_function.vectorize(message_ids)
  }
end
function tdLua_function.getFile(file_id)
  return function_core.run_table{
    tdLua = 'getFile',
    file_id = file_id
  }
end
function tdLua_function.getRemoteFile(remote_file_id, file_type)
  return function_core.run_table{
    tdLua = 'getRemoteFile',
    remote_file_id = tostring(remote_file_id),
    file_type = {
      tdLua = 'fileType' .. file_type or 'Unknown'
    }
  }
end
function tdLua_function.getChats(chat_list, offset_order, offset_chat_id, limit)
  local limit = limit or 20
  local offset_order = offset_order or '9223372036854775807'
  local offset_chat_id = offset_chat_id or 0
  local filter = (string.lower(tostring(chat_list)) == 'archive') and 'chatListArchive' or 'chatListMain'
  return function_core.run_table{
    tdLua = 'getChats',
    offset_order = offset_order,
    offset_chat_id = offset_chat_id,
    limit = tdLua_function.setLimit(100, limit),
    chat_list = {
      tdLua = filter
    }
  }
end
function tdLua_function.searchPublicChat(username)
  return function_core.run_table{
    tdLua = 'searchPublicChat',
    username = tostring(username)
  }
end
function tdLua_function.searchPublicChats(query)
  return function_core.run_table{
    tdLua = 'searchPublicChats',
    query = tostring(query)
  }
end
function tdLua_function.searchChats(query, limit)
  return function_core.run_table{
    tdLua = 'searchChats',
    query = tostring(query),
    limit = limit
  }
end
function tdLua_function.checkChatUsername(chat_id, username)
  return function_core.run_table{
    tdLua = 'checkChatUsername',
    chat_id = chat_id,
    username = tostring(username)
  }
end
function tdLua_function.searchChatsOnServer(query, limit)
  return function_core.run_table{
    tdLua = 'searchChatsOnServer',
    query = tostring(query),
    limit = limit
  }
end
function tdLua_function.clearRecentlyFoundChats()
  return function_core.run_table{
    tdLua = 'clearRecentlyFoundChats'
  }
end
function tdLua_function.getTopChats(category, limit)
  return function_core.run_table{
    tdLua = 'getTopChats',
    category = {
      tdLua = 'topChatCategory' .. category
    },
    limit = tdLua_function.setLimit(30, limit)
  }
end
function tdLua_function.removeTopChat(category, chat_id)
  return function_core.run_table{
    tdLua = 'removeTopChat',
    category = {
      tdLua = 'topChatCategory' .. category
    },
    chat_id = chat_id
  }
end
function tdLua_function.addRecentlyFoundChat(chat_id)
  return function_core.run_table{
    tdLua = 'addRecentlyFoundChat',
    chat_id = chat_id
  }
end
function tdLua_function.getCreatedPublicChats()
  return function_core.run_table{
    tdLua = 'getCreatedPublicChats'
  }
end
function tdLua_function.removeRecentlyFoundChat(chat_id)
  return function_core.run_table{
    tdLua = 'removeRecentlyFoundChat',
    chat_id = chat_id
  }
end
function tdLua_function.getChatHistory(chat_id, from_message_id, offset, limit, only_local)
  return function_core.run_table{
    tdLua = 'getChatHistory',
    chat_id = chat_id,
    from_message_id = from_message_id,
    offset = offset,
    limit = tdLua_function.setLimit(100, limit),
    only_local = only_local
  }
end
function tdLua_function.getGroupsInCommon(user_id, offset_chat_id, limit)
  return function_core.run_table{
    tdLua = 'getGroupsInCommon',
    user_id = user_id,
    offset_chat_id = offset_chat_id or 0,
    limit = tdLua_function.setLimit(100, limit)
  }
end
function tdLua_function.searchMessages(query, offset_date, offset_chat_id, offset_message_id, limit)
  return function_core.run_table{
    tdLua = 'searchMessages',
    query = tostring(query),
    offset_date = offset_date or 0,
    offset_chat_id = offset_chat_id or 0,
    offset_message_id = offset_message_id or 0,
    limit = tdLua_function.setLimit(100, limit)
  }
end
function tdLua_function.searchChatMessages(chat_id, query, filter, sender_user_id, from_message_id, offset, limit)
  return function_core.run_table{
    tdLua = 'searchChatMessages',
    chat_id = chat_id,
    query = tostring(query),
    sender_user_id = sender_user_id or 0,
    from_message_id = from_message_id or 0,
    offset = offset or 0,
    limit = tdLua_function.setLimit(100, limit),
    filter = {
      tdLua = 'searchMessagesFilter' .. filter
    }
  }
end
function tdLua_function.searchSecretMessages(chat_id, query, from_search_id, limit, filter)
  local filter = filter or 'Empty'
  return function_core.run_table{
    tdLua = 'searchSecretMessages',
    chat_id = chat_id or 0,
    query = tostring(query),
    from_search_id = from_search_id or 0,
    limit = tdLua_function.setLimit(100, limit),
    filter = {
      tdLua = 'searchMessagesFilter' .. filter
    }
  }
end
function tdLua_function.deleteChatHistory(chat_id, remove_from_chat_list)
  return function_core.run_table{
    tdLua = 'deleteChatHistory',
    chat_id = chat_id,
    remove_from_chat_list = remove_from_chat_list
  }
end
function tdLua_function.searchCallMessages(from_message_id, limit, only_missed)
  return function_core.run_table{
    tdLua = 'searchCallMessages',
    from_message_id = from_message_id or 0,
    limit = tdLua_function.setLimit(100, limit),
    only_missed = only_missed
  }
end
function tdLua_function.getChatMessageByDate(chat_id, date)
  return function_core.run_table{
    tdLua = 'getChatMessageByDate',
    chat_id = chat_id,
    date = date
  }
end
function tdLua_function.getPublicMessageLink(chat_id, message_id, for_album)
  return function_core.run_table{
    tdLua = 'getPublicMessageLink',
    chat_id = chat_id,
    message_id = message_id,
    for_album = for_album
  }
end
function tdLua_function.sendMessageAlbum(chat_id, reply_to_message_id, input_message_contents, disable_notification, from_background)
  return function_core.run_table{
    tdLua = 'sendMessageAlbum',
    chat_id = chat_id,
    reply_to_message_id = reply_to_message_id or 0,
    disable_notification = disable_notification,
    from_background = from_background,
    input_message_contents = tdLua_function.vectorize(input_message_contents)
  }
end
function tdLua_function.sendBotStartMessage(bot_user_id, chat_id, parameter)
  return function_core.run_table{
    tdLua = 'sendBotStartMessage',
    bot_user_id = bot_user_id,
    chat_id = chat_id,
    parameter = tostring(parameter)
  }
end
function tdLua_function.sendInlineQueryResultMessage(chat_id, reply_to_message_id, disable_notification, from_background, query_id, result_id)
  return function_core.run_table{
    tdLua = 'sendInlineQueryResultMessage',
    chat_id = chat_id,
    reply_to_message_id = reply_to_message_id,
    disable_notification = disable_notification,
    from_background = from_background,
    query_id = query_id,
    result_id = tostring(result_id)
  }
end
function tdLua_function.forwardMessages(chat_id, from_chat_id, message_ids, disable_notification, from_background, as_album, send_copy, remove_caption)
  return function_core.run_table{
    tdLua = 'forwardMessages',
    chat_id = chat_id,
    from_chat_id = from_chat_id,
    message_ids = tdLua_function.vectorize(message_ids),
    disable_notification = disable_notification,
    from_background = from_background,
    as_album = as_album,
    send_copy = send_copy,
    remove_caption = remove_caption
  }
end
function tdLua_function.sendChatSetTtlMessage(chat_id, ttl)
  return function_core.run_table{
    tdLua = 'sendChatSetTtlMessage',
    chat_id = chat_id,
    ttl = ttl
  }
end
function tdLua_function.sendChatScreenshotTakenNotification(chat_id)
  return function_core.run_table{
    tdLua = 'sendChatScreenshotTakenNotification',
    chat_id = chat_id
  }
end
function tdLua_function.deleteMessages(chat_id, message_ids, revoke)
  return function_core.run_table{
    tdLua = 'deleteMessages',
    chat_id = chat_id,
    message_ids = tdLua_function.vectorize(message_ids),
    revoke = revoke
  }
end
function tdLua_function.deleteChatMessagesFromUser(chat_id, user_id)
  return function_core.run_table{
    tdLua = 'deleteChatMessagesFromUser',
    chat_id = chat_id,
    user_id = user_id
  }
end
function tdLua_function.editMessageText(chat_id, message_id, text, parse_mode, disable_web_page_preview, clear_draft, reply_markup)
  local tdLua_body = {
    tdLua = 'editMessageText',
    chat_id = chat_id,
    message_id = message_id,
    reply_markup = reply_markup,
    input_message_content = {
      tdLua = 'inputMessageText',
      disable_web_page_preview = disable_web_page_preview,
      text = {
        text = text
      },
      clear_draft = clear_draft
    }
  }
  if parse_mode then
    tdLua_body.input_message_content.text = tdLua_function.parseTextEntities(text, parse_mode)
  end
  return function_core.run_table(tdLua_body)
end
function tdLua_function.editMessageCaption(chat_id, message_id, caption, parse_mode, reply_markup)
  local tdLua_body = {
    tdLua = 'editMessageCaption',
    chat_id = chat_id,
    message_id = message_id,
    reply_markup = reply_markup,
    caption = caption
  }
  if parse_mode then
      tdLua_body.caption = tdLua_function.parseTextEntities(text,parse_mode)
  end
  return function_core.run_table(tdLua_body)
end
function tdLua_function.getTextEntities(text)
  return function_core.run_table{
    tdLua = 'getTextEntities',
    text = tostring(text)
  }
end
function tdLua_function.getFileMimeType(file_name)
  return function_core.run_table{
    tdLua = 'getFileMimeType',
    file_name = tostring(file_name)
  }
end
function tdLua_function.getFileExtension(mime_type)
  return function_core.run_table{
    tdLua = 'getFileExtension',
    mime_type = tostring(mime_type)
  }
end
function tdLua_function.getInlineQueryResults(bot_user_id, chat_id, latitude, longitude, query, offset)
  return function_core.run_table{
    tdLua = 'getInlineQueryResults',
    bot_user_id = bot_user_id,
    chat_id = chat_id,
    user_location = {
      tdLua = 'location',
      latitude = latitude,
      longitude = longitude
    },
    query = tostring(query),
    offset = tostring(offset)
  }
end
function tdLua_function.answerCallbackQuery(callback_query_id, text, show_alert, url, cache_time)
  return function_core.run_table{
        tdLua = 'answerCallbackQuery',
        callback_query_id = callback_query_id,
        show_alert = show_alert,
        cache_time = cache_time,
        text = text,
        url = url,
  }
end
function tdLua_function.getCallbackQueryAnswer(chat_id, message_id, payload, data, game_short_name)
  return function_core.run_table{
    tdLua = 'getCallbackQueryAnswer',
    chat_id = chat_id,
    message_id = message_id,
    payload = {
      tdLua = 'callbackQueryPayload' .. payload,
      data = data,
      game_short_name = game_short_name
    }
  }
end
function tdLua_function.deleteChatReplyMarkup(chat_id, message_id)
  return function_core.run_table{
    tdLua = 'deleteChatReplyMarkup',
    chat_id = chat_id,
    message_id = message_id
  }
end
function tdLua_function.sendChatAction(chat_id, action, progress)
  return function_core.run_table{
    tdLua = 'sendChatAction',
    chat_id = chat_id,
    action = {
      tdLua = 'chatAction' .. action,
      progress = progress or 100
    }
  }
end
function tdLua_function.openChat(chat_id)
  return function_core.run_table{
    tdLua = 'openChat',
    chat_id = chat_id
  }
end
function tdLua_function.closeChat(chat_id)
  return function_core.run_table{
    tdLua = 'closeChat',
    chat_id = chat_id
  }
end
function tdLua_function.viewMessages(chat_id, message_ids, force_read)
  return function_core.run_table{
    tdLua = 'viewMessages',
    chat_id = chat_id,
    message_ids = tdLua_function.vectorize(message_ids),
    force_read = force_read
  }
end
function tdLua_function.openMessageContent(chat_id, message_id)
  return function_core.run_table{
    tdLua = 'openMessageContent',
    chat_id = chat_id,
    message_id = message_id
  }
end
function tdLua_function.readAllChatMentions(chat_id)
  return function_core.run_table{
    tdLua = 'readAllChatMentions',
    chat_id = chat_id
  }
end
function tdLua_function.createPrivateChat(user_id, force)
  return function_core.run_table{
    tdLua = 'createPrivateChat',
    user_id = user_id,
    force = force
  }
end
function tdLua_function.createBasicGroupChat(basic_group_id, force)
  return function_core.run_table{
    tdLua = 'createBasicGroupChat',
    basic_group_id = tdLua_function.getChatId(basic_group_id).id,
    force = force
  }
end
function tdLua_function.createSupergroupChat(supergroup_id, force)
  return function_core.run_table{
    tdLua = 'createSupergroupChat',
    supergroup_id = tdLua_function.getChatId(supergroup_id).id,
    force = force
  }
end
function tdLua_function.createSecretChat(secret_chat_id)
  return function_core.run_table{
    tdLua = 'createSecretChat',
    secret_chat_id = secret_chat_id
  }
end
function tdLua_function.createNewBasicGroupChat(user_ids, title)
  return function_core.run_table{
    tdLua = 'createNewBasicGroupChat',
    user_ids = tdLua_function.vectorize(user_ids),
    title = tostring(title)
  }
end
function tdLua_function.createNewSupergroupChat(title, is_channel, description)
  return function_core.run_table{
    tdLua = 'createNewSupergroupChat',
    title = tostring(title),
    is_channel = is_channel,
    description = tostring(description)
  }
end
function tdLua_function.createNewSecretChat(user_id)
  return function_core.run_table{
    tdLua = 'createNewSecretChat',
    user_id = tonumber(user_id)
  }
end
function tdLua_function.upgradeBasicGroupChatToSupergroupChat(chat_id)
  return function_core.run_table{
    tdLua = 'upgradeBasicGroupChatToSupergroupChat',
    chat_id = chat_id
  }
end
function tdLua_function.setChatPermissions(chat_id, can_send_messages, can_send_media_messages, can_send_polls, can_send_other_messages, can_add_web_page_previews, can_change_info, can_invite_users, can_pin_messages)
  return function_core.run_table{
    tdLua = 'setChatPermissions',
    chat_id = chat_id,
     permissions = {
      can_send_messages = can_send_messages,
      can_send_media_messages = can_send_media_messages,
      can_send_polls = can_send_polls,
      can_send_other_messages = can_send_other_messages,
      can_add_web_page_previews = can_add_web_page_previews,
      can_change_info = can_change_info,
      can_invite_users = can_invite_users,
      can_pin_messages = can_pin_messages,
    }
  }
end
function tdLua_function.setChatTitle(chat_id, title)
  return function_core.run_table{
    tdLua = 'setChatTitle',
    chat_id = chat_id,
    title = tostring(title)
  }
end
function tdLua_function.setChatPhoto(chat_id, photo)
  return function_core.run_table{
    tdLua = 'setChatPhoto',
    chat_id = chat_id,
    photo = getInputFile(photo)
  }
end
function tdLua_function.setChatDraftMessage(chat_id, reply_to_message_id, text, parse_mode, disable_web_page_preview, clear_draft)
  local tdLua_body = {
    tdLua = 'setChatDraftMessage',
    chat_id = chat_id,
    draft_message = {
      tdLua = 'draftMessage',
      reply_to_message_id = reply_to_message_id,
      input_message_text = {
        tdLua = 'inputMessageText',
        disable_web_page_preview = disable_web_page_preview,
        text = {text = text},
        clear_draft = clear_draft
      }
    }
  }
  if parse_mode then
      tdLua_body.draft_message.input_message_text.text = tdLua_function.parseTextEntities(text, parse_mode)
  end
  return function_core.run_table(tdLua_body)
end
function tdLua_function.toggleChatIsPinned(chat_id, is_pinned)
  return function_core.run_table{
    tdLua = 'toggleChatIsPinned',
    chat_id = chat_id,
    is_pinned = is_pinned
  }
end
function tdLua_function.setChatClientData(chat_id, client_data)
  return function_core.run_table{
    tdLua = 'setChatClientData',
    chat_id = chat_id,
    client_data = tostring(client_data)
  }
end
function tdLua_function.addChatMember(chat_id, user_id, forward_limit)
  return function_core.run_table{
    tdLua = 'addChatMember',
    chat_id = chat_id,
    user_id = user_id,
    forward_limit = tdLua_function.setLimit(300, forward_limit)
  }
end
function tdLua_function.addChatMembers(chat_id, user_ids)
  return function_core.run_table{
    tdLua = 'addChatMembers',
    chat_id = chat_id,
    user_ids = tdLua_function.vectorize(user_ids)
  }
end
function tdLua_function.setChatMemberStatus(chat_id, user_id, status, right)
  local right = right and tdLua_function.vectorize(right) or {}
  local status = string.lower(status)
  if status == 'creator' then
    chat_member_status = {
      tdLua = 'chatMemberStatusCreator',
      is_member = right[1] or 1
    }
  elseif status == 'administrator' then
    chat_member_status = {
      tdLua = 'chatMemberStatusAdministrator',
      can_be_edited = right[1] or 1,
      can_change_info = right[2] or 1,
      can_post_messages = right[3] or 1,
      can_edit_messages = right[4] or 1,
      can_delete_messages = right[5] or 1,
      can_invite_users = right[6] or 1,
      can_restrict_members = right[7] or 1,
      can_pin_messages = right[8] or 1,
      can_promote_members = right[9] or 0
    }
  elseif status == 'restricted' then
    chat_member_status = {
      permissions = {
        tdLua = 'chatPermissions',
        can_send_polls = right[2] or 0,
        can_add_web_page_previews = right[3] or 1,
        can_change_info = right[4] or 0,
        can_invite_users = right[5] or 1,
        can_pin_messages = right[6] or 0,
        can_send_media_messages = right[7] or 1,
        can_send_messages = right[8] or 1,
        can_send_other_messages = right[9] or 1
      },
      is_member = right[1] or 1,
      restricted_until_date = right[10] or 0,
      tdLua = 'chatMemberStatusRestricted'
    }
  elseif status == 'banned' then
    chat_member_status = {
      tdLua = 'chatMemberStatusBanned',
      banned_until_date = right[1] or 0
    }
  end
  return function_core.run_table{
    tdLua = 'setChatMemberStatus',
    chat_id = chat_id,
    user_id = user_id,
    status = chat_member_status or {}
  }
end


function tdLua_function.getChatMember(chat_id, user_id)
  return function_core.run_table{
    tdLua = 'getChatMember',
    chat_id = chat_id,
    user_id = user_id
  }
end
function tdLua_function.searchChatMembers(chat_id, query, limit)
  return function_core.run_table{
    tdLua = 'searchChatMembers',
    chat_id = chat_id,
    query = tostring(query),
    limit = tdLua_function.setLimit(200, limit)
  }
end
function tdLua_function.getChatAdministrators(chat_id)
  return function_core.run_table{
    tdLua = 'getChatAdministrators',
    chat_id = chat_id
  }
end
function tdLua_function.setPinnedChats(chat_ids)
  return function_core.run_table{
    tdLua = 'setPinnedChats',
    chat_ids = tdLua_function.vectorize(chat_ids)
  }
end
function tdLua_function.downloadFile(file_id, priority)
  return function_core.run_table{
    tdLua = 'downloadFile',
    file_id = file_id,
    priority = priority or 32
  }
end
function tdLua_function.cancelDownloadFile(file_id, only_if_pending)
  return function_core.run_table{
    tdLua = 'cancelDownloadFile',
    file_id = file_id,
    only_if_pending = only_if_pending
  }
end
function tdLua_function.uploadFile(file, file_type, priority)
  local ftype = file_type or 'Unknown'
  return function_core.run_table{
    tdLua = 'uploadFile',
    file = tdLua_function.getInputFile(file),
    file_type = {
      tdLua = 'fileType' .. ftype
    },
    priority = priority or 32
  }
end
function tdLua_function.cancelUploadFile(file_id)
  return function_core.run_table{
    tdLua = 'cancelUploadFile',
    file_id = file_id
  }
end
function tdLua_function.deleteFile(file_id)
  return function_core.run_table{
    tdLua = 'deleteFile',
    file_id = file_id
  }
end
function tdLua_function.generateChatInviteLink(chat_id)
  return function_core.run_table{
    tdLua = 'generateChatInviteLink',
    chat_id = chat_id
  }
end
function tdLua_function.joinChatByUsernam(username)
  if type(username) == 'string' and 5 <= #username then
    local result = tdLua_function.searchPublicChat(username)
    if result.type and result.type.tdLua == 'chatTypeSupergroup' then
      return function_core.run_table{
        tdLua = 'joinChat',
        chat_id = result.id
      }
    else
      return result
    end
  end
end
function tdLua_function.checkChatInviteLink(invite_link)
  return function_core.run_table{
    tdLua = 'checkChatInviteLink',
    invite_link = tostring(invite_link)
  }
end
function tdLua_function.joinChatByInviteLink(invite_link)
  return function_core.run_table{
    tdLua = 'joinChatByInviteLink',
    invite_link = tostring(invite_link)
  }
end
function tdLua_function.leaveChat(chat_id)
  return  function_core.run_table{
    tdLua = 'leaveChat',
    chat_id = chat_id
  }
end
function tdLua_function.createCall(user_id, udp_p2p, udp_reflector, min_layer, max_layer)
  return function_core.run_table{
    tdLua = 'createCall',
    user_id = user_id,
    protocol = {
      tdLua = 'callProtocol',
      udp_p2p = udp_p2p,
      udp_reflector = udp_reflector,
      min_layer = min_layer or 65,
      max_layer = max_layer or 65
    }
  }
end
function tdLua_function.acceptCall(call_id, udp_p2p, udp_reflector, min_layer, max_layer)
  return function_core.run_table{
    tdLua = 'acceptCall',
    call_id = call_id,
    protocol = {
      tdLua = 'callProtocol',
      udp_p2p = udp_p2p,
      udp_reflector = udp_reflector,
      min_layer = min_layer or 65,
      max_layer = max_layer or 65
    }
  }
end
function tdLua_function.blockUser(user_id)
  return function_core.run_table{
    tdLua = 'blockUser',
    user_id = user_id
  }
end
function tdLua_function.unblockUser(user_id)
  return function_core.run_table{
    tdLua = 'unblockUser',
    user_id = user_id
  }
end
function tdLua_function.getBlockedUsers(offset, limit)
  return function_core.run_table{
    tdLua = 'getBlockedUsers',
    offset = offset or 0,
    limit = tdLua_function.setLimit(100, limit)
  }
end
function tdLua_function.getContacts()
  return function_core.run_table{
    tdLua = 'getContacts'
  }
end
function tdLua_function.importContacts(contacts)
  local result = {}
  for key, value in pairs(contacts) do
    result[#result + 1] = {
      tdLua = 'contact',
      phone_number = tostring(value.phone_number),
      first_name = tostring(value.first_name),
      last_name = tostring(value.last_name),
      user_id = value.user_id or 0
    }
  end
  return function_core.run_table{
    tdLua = 'importContacts',
    contacts = result
  }
end
function tdLua_function.searchContacts(query, limit)
  return function_core.run_table{
    tdLua = 'searchContacts',
    query = tostring(query),
    limit = limit
  }
end
function tdLua_function.removeContacts(user_ids)
  return function_core.run_table{
    tdLua = 'removeContacts',
    user_ids = tdLua_function.vectorize(user_ids)
  }
end
function tdLua_function.getImportedContactCount()
  return function_core.run_table{
    tdLua = 'getImportedContactCount'
  }
end
function tdLua_function.changeImportedContacts(phone_number, first_name, last_name, user_id)
  return function_core.run_table{
    tdLua = 'changeImportedContacts',
    contacts = {
      tdLua = 'contact',
      phone_number = tostring(phone_number),
      first_name = tostring(first_name),
      last_name = tostring(last_name),
      user_id = user_id or 0
    }
  }
end
function tdLua_function.clearImportedContacts()
  return function_core.run_table{
    tdLua = 'clearImportedContacts'
  }
end
function tdLua_function.getUserProfilePhotos(user_id, offset, limit)
  return function_core.run_table{
    tdLua = 'getUserProfilePhotos',
    user_id = user_id,
    offset = offset or 0,
    limit = tdLua_function.setLimit(100, limit)
  }
end
function tdLua_function.getStickers(emoji, limit)
  return function_core.run_table{
    tdLua = 'getStickers',
    emoji = tostring(emoji),
    limit = tdLua_function.setLimit(100, limit)
  }
end
function tdLua_function.searchStickers(emoji, limit)
  return function_core.run_table{
    tdLua = 'searchStickers',
    emoji = tostring(emoji),
    limit = limit
  }
end
function tdLua_function.getArchivedStickerSets(is_masks, offset_sticker_set_id, limit)
  return function_core.run_table{
    tdLua = 'getArchivedStickerSets',
    is_masks = is_masks,
    offset_sticker_set_id = offset_sticker_set_id,
    limit = limit
  }
end
function tdLua_function.getTrendingStickerSets()
  return function_core.run_table{
    tdLua = 'getTrendingStickerSets'
  }
end
function tdLua_function.getAttachedStickerSets(file_id)
  return function_core.run_table{
    tdLua = 'getAttachedStickerSets',
    file_id = file_id
  }
end
function tdLua_function.getStickerSet(set_id)
  return function_core.run_table{
    tdLua = 'getStickerSet',
    set_id = set_id
  }
end
function tdLua_function.searchStickerSet(name)
  return function_core.run_table{
    tdLua = 'searchStickerSet',
    name = tostring(name)
  }
end
function tdLua_function.searchInstalledStickerSets(is_masks, query, limit)
  return function_core.run_table{
    tdLua = 'searchInstalledStickerSets',
    is_masks = is_masks,
    query = tostring(query),
    limit = limit
  }
end
function tdLua_function.searchStickerSets(query)
  return function_core.run_table{
    tdLua = 'searchStickerSets',
    query = tostring(query)
  }
end
function tdLua_function.changeStickerSet(set_id, is_installed, is_archived)
  return function_core.run_table{
    tdLua = 'changeStickerSet',
    set_id = set_id,
    is_installed = is_installed,
    is_archived = is_archived
  }
end
function tdLua_function.viewTrendingStickerSets(sticker_set_ids)
  return function_core.run_table{
    tdLua = 'viewTrendingStickerSets',
    sticker_set_ids = tdLua_function.vectorize(sticker_set_ids)
  }
end
function tdLua_function.reorderInstalledStickerSets(is_masks, sticker_set_ids)
  return function_core.run_table{
    tdLua = 'reorderInstalledStickerSets',
    is_masks = is_masks,
    sticker_set_ids = tdLua_function.vectorize(sticker_set_ids)
  }
end
function tdLua_function.getRecentStickers(is_attached)
  return function_core.run_table{
    tdLua = 'getRecentStickers',
    is_attached = is_attached
  }
end
function tdLua_function.addRecentSticker(is_attached, sticker)
  return function_core.run_table{
    tdLua = 'addRecentSticker',
    is_attached = is_attached,
    sticker = tdLua_function.getInputFile(sticker)
  }
end
function tdLua_function.clearRecentStickers(is_attached)
  return function_core.run_table{
    tdLua = 'clearRecentStickers',
    is_attached = is_attached
  }
end
function tdLua_function.getFavoriteStickers()
  return function_core.run_table{
    tdLua = 'getFavoriteStickers'
  }
end
function tdLua_function.addFavoriteSticker(sticker)
  return function_core.run_table{
    tdLua = 'addFavoriteSticker',
    sticker = tdLua_function.getInputFile(sticker)
  }
end
function tdLua_function.removeFavoriteSticker(sticker)
  return function_core.run_table{
    tdLua = 'removeFavoriteSticker',
    sticker = tdLua_function.getInputFile(sticker)
  }
end
function tdLua_function.getStickerEmojis(sticker)
  return function_core.run_table{
    tdLua = 'getStickerEmojis',
    sticker = tdLua_function.getInputFile(sticker)
  }
end
function tdLua_function.getSavedAnimations()
  return function_core.run_table{
    tdLua = 'getSavedAnimations'
  }
end
function tdLua_function.addSavedAnimation(animation)
  return function_core.run_table{
    tdLua = 'addSavedAnimation',
    animation = tdLua_function.getInputFile(animation)
  }
end
function tdLua_function.removeSavedAnimation(animation)
  return function_core.run_table{
    tdLua = 'removeSavedAnimation',
    animation = tdLua_function.getInputFile(animation)
  }
end
function tdLua_function.getRecentInlineBots()
  return function_core.run_table{
    tdLua = 'getRecentInlineBots'
  }
end
function tdLua_function.searchHashtags(prefix, limit)
  return function_core.run_table{
    tdLua = 'searchHashtags',
    prefix = tostring(prefix),
    limit = limit
  }
end
function tdLua_function.removeRecentHashtag(hashtag)
  return function_core.run_table{
    tdLua = 'removeRecentHashtag',
    hashtag = tostring(hashtag)
  }
end
function tdLua_function.getWebPagePreview(text)
  return function_core.run_table{
    tdLua = 'getWebPagePreview',
    text = {
      text = text
    }
  }
end
function tdLua_function.getWebPageInstantView(url, force_full)
  return function_core.run_table{
    tdLua = 'getWebPageInstantView',
    url = tostring(url),
    force_full = force_full
  }
end
function tdLua_function.getNotificationSettings(scope, chat_id)
  return function_core.run_table{
    tdLua = 'getNotificationSettings',
    scope = {
      tdLua = 'notificationSettingsScope' .. scope,
      chat_id = chat_id
    }
  }
end
function tdLua_function.setNotificationSettings(scope, chat_id, mute_for, sound, show_preview)
  return function_core.run_table{
    tdLua = 'setNotificationSettings',
    scope = {
      tdLua = 'notificationSettingsScope' .. scope,
      chat_id = chat_id
    },
    notification_settings = {
      tdLua = 'notificationSettings',
      mute_for = mute_for,
      sound = tostring(sound),
      show_preview = show_preview
    }
  }
end
function tdLua_function.resetAllNotificationSettings()
  return function_core.run_table{
    tdLua = 'resetAllNotificationSettings'
  }
end
function tdLua_function.setProfilePhoto(photo)
  return function_core.run_table{
    tdLua = 'setProfilePhoto',
    photo = tdLua_function.getInputFile(photo)
  }
end
function tdLua_function.deleteProfilePhoto(profile_photo_id)
  return function_core.run_table{
    tdLua = 'deleteProfilePhoto',
    profile_photo_id = profile_photo_id
  }
end
function tdLua_function.setName(first_name, last_name)
  return function_core.run_table{
    tdLua = 'setName',
    first_name = tostring(first_name),
    last_name = tostring(last_name)
  }
end
function tdLua_function.setBio(bio)
  return function_core.run_table{
    tdLua = 'setBio',
    bio = tostring(bio)
  }
end
function tdLua_function.setUsername(username)
  return function_core.run_table{
    tdLua = 'setUsername',
    username = tostring(username)
  }
end
function tdLua_function.getActiveSessions()
  return function_core.run_table{
    tdLua = 'getActiveSessions'
  }
end
function tdLua_function.terminateAllOtherSessions()
  return function_core.run_table{
    tdLua = 'terminateAllOtherSessions'
  }
end
function tdLua_function.terminateSession(session_id)
  return function_core.run_table{
    tdLua = 'terminateSession',
    session_id = session_id
  }
end
function tdLua_function.toggleBasicGroupAdministrators(basic_group_id, everyone_is_administrator)
  return function_core.run_table{
    tdLua = 'toggleBasicGroupAdministrators',
    basic_group_id = tdLua_function.getChatId(basic_group_id).id,
    everyone_is_administrator = everyone_is_administrator
  }
end
function tdLua_function.setSupergroupUsername(supergroup_id, username)
  return function_core.run_table{
    tdLua = 'setSupergroupUsername',
    supergroup_id = tdLua_function.getChatId(supergroup_id).id,
    username = tostring(username)
  }
end
function tdLua_function.setSupergroupStickerSet(supergroup_id, sticker_set_id)
  return function_core.run_table{
    tdLua = 'setSupergroupStickerSet',
    supergroup_id = tdLua_function.getChatId(supergroup_id).id,
    sticker_set_id = sticker_set_id
  }
end
function tdLua_function.toggleSupergroupInvites(supergroup_id, anyone_can_invite)
  return function_core.run_table{
    tdLua = 'toggleSupergroupInvites',
    supergroup_id = tdLua_function.getChatId(supergroup_id).id,
    anyone_can_invite = anyone_can_invite
  }
end
function tdLua_function.toggleSupergroupSignMessages(supergroup_id, sign_messages)
  return function_core.run_table{
    tdLua = 'toggleSupergroupSignMessages',
    supergroup_id = tdLua_function.getChatId(supergroup_id).id,
    sign_messages = sign_messages
  }
end
function tdLua_function.toggleSupergroupIsAllHistoryAvailable(supergroup_id, is_all_history_available)
  return function_core.run_table{
    tdLua = 'toggleSupergroupIsAllHistoryAvailable',
    supergroup_id = tdLua_function.getChatId(supergroup_id).id,
    is_all_history_available = is_all_history_available
  }
end
function tdLua_function.setChatDescription(chat_id, description)
  return function_core.run_table{
    tdLua = 'setChatDescription',
    chat_id = chat_id,
    description = tostring(description)
  }
end
function tdLua_function.pinChatMessage(chat_id, message_id, disable_notification)
  return function_core.run_table{
    tdLua = 'pinChatMessage',
    chat_id = chat_id,
    message_id = message_id,
    disable_notification = disable_notification
  }
end
function tdLua_function.unpinChatMessage(chat_id)
  return function_core.run_table{
    tdLua = 'unpinChatMessage',
    chat_id = chat_id
  }
end
function tdLua_function.reportSupergroupSpam(supergroup_id, user_id, message_ids)
  return function_core.run_table{
    tdLua = 'reportSupergroupSpam',
    supergroup_id = tdLua_function.getChatId(supergroup_id).id,
    user_id = user_id,
    message_ids = tdLua_function.vectorize(message_ids)
  }
end
function tdLua_function.getSupergroupMembers(supergroup_id, filter, query, offset, limit)
  local filter = filter or 'Recent'
  return function_core.run_table{
    tdLua = 'getSupergroupMembers',
    supergroup_id = tdLua_function.getChatId(supergroup_id).id,
    filter = {
      tdLua = 'supergroupMembersFilter' .. filter,
      query = query
    },
    offset = offset or 0,
    limit = tdLua_function.setLimit(200, limit)
  }
end
function tdLua_function.deleteSupergroup(supergroup_id)
  return function_core.run_table{
    tdLua = 'deleteSupergroup',
    supergroup_id = tdLua_function.getChatId(supergroup_id).id
  }
end
function tdLua_function.closeSecretChat(secret_chat_id)
  return function_core.run_table{
    tdLua = 'closeSecretChat',
    secret_chat_id = secret_chat_id
  }
end
function tdLua_function.getChatEventLog(chat_id, query, from_event_id, limit, filters, user_ids)
  local filters = filters or {1,1,1,1,1,1,1,1,1,1}
  return function_core.run_table{
    tdLua = 'getChatEventLog',
    chat_id = chat_id,
    query = tostring(query) or '',
    from_event_id = from_event_id or 0,
    limit = tdLua_function.setLimit(100, limit),
    filters = {
      tdLua = 'chatEventLogFilters',
      message_edits = filters[0],
      message_deletions = filters[1],
      message_pins = filters[2],
      member_joins = filters[3],
      member_leaves = filters[4],
      member_invites = filters[5],
      member_promotions = filters[6],
      member_restrictions = filters[7],
      info_changes = filters[8],
      setting_changes = filters[9]
    },
    user_ids = tdLua_function.vectorize(user_ids)
  }
end
function tdLua_function.getSavedOrderInfo()
  return function_core.run_table{
    tdLua = 'getSavedOrderInfo'
  }
end
function tdLua_function.deleteSavedOrderInfo()
  return function_core.run_table{
    tdLua = 'deleteSavedOrderInfo'
  }
end
function tdLua_function.deleteSavedCredentials()
  return function_core.run_table{
    tdLua = 'deleteSavedCredentials'
  }
end
function tdLua_function.getSupportUser()
  return function_core.run_table{
    tdLua = 'getSupportUser'
  }
end
function tdLua_function.getWallpapers()
  return function_core.run_table{
    tdLua = 'getWallpapers'
  }
end
function tdLua_function.setUserPrivacySettingRules(setting, rules, allowed_user_ids, restricted_user_ids)
  local setting_rules = {
    [0] = {
      tdLua = 'userPrivacySettingRule' .. rules
    }
  }
  if allowed_user_ids then
    setting_rules[#setting_rules + 1] = {
      {
        tdLua = 'userPrivacySettingRuleAllowUsers',
        user_ids = tdLua_function.vectorize(allowed_user_ids)
      }
    }
  elseif restricted_user_ids then
    setting_rules[#setting_rules + 1] = {
      {
        tdLua = 'userPrivacySettingRuleRestrictUsers',
        user_ids = tdLua_function.vectorize(restricted_user_ids)
      }
    }
  end
  return function_core.run_table{
    tdLua = 'setUserPrivacySettingRules',
    setting = {
      tdLua = 'userPrivacySetting' .. setting
    },
    rules = {
      tdLua = 'userPrivacySettingRules',
      rules = setting_rules
    }
  }
end
function tdLua_function.getUserPrivacySettingRules(setting)
  return function_core.run_table{
    tdLua = 'getUserPrivacySettingRules',
    setting = {
      tdLua = 'userPrivacySetting' .. setting
    }
  }
end
function tdLua_function.getOption(name)
  return function_core.run_table{
    tdLua = 'getOption',
    name = tostring(name)
  }
end
function tdLua_function.setOption(name, option_value, value)
  return function_core.run_table{
    tdLua = 'setOption',
    name = tostring(name),
    value = {
      tdLua = 'optionValue' .. option_value,
      value = value
    }
  }
end
function tdLua_function.setAccountTtl(ttl)
  return function_core.run_table{
    tdLua = 'setAccountTtl',
    ttl = {
      tdLua = 'accountTtl',
      days = ttl
    }
  }
end
function tdLua_function.getAccountTtl()
  return function_core.run_table{
    tdLua = 'getAccountTtl'
  }
end
function tdLua_function.deleteAccount(reason)
  return function_core.run_table{
    tdLua = 'deleteAccount',
    reason = tostring(reason)
  }
end
function tdLua_function.getChatReportSpamState(chat_id)
  return function_core.run_table{
    tdLua = 'getChatReportSpamState',
    chat_id = chat_id
  }
end
function tdLua_function.reportChat(chat_id, reason, text, message_ids)
  return function_core.run_table{
    tdLua = 'reportChat',
    chat_id = chat_id,
    reason = {
      tdLua = 'chatReportReason' .. reason,
      text = text
    },
    message_ids = tdLua_function.vectorize(message_ids)
  }
end
function tdLua_function.getStorageStatistics(chat_limit)
  return function_core.run_table{
    tdLua = 'getStorageStatistics',
    chat_limit = chat_limit
  }
end
function tdLua_function.getStorageStatisticsFast()
  return function_core.run_table{
    tdLua = 'getStorageStatisticsFast'
  }
end
function tdLua_function.optimizeStorage(size, ttl, count, immunity_delay, file_type, chat_ids, exclude_chat_ids, chat_limit)
  local file_type = file_type or ''
  return function_core.run_table{
    tdLua = 'optimizeStorage',
    size = size or -1,
    ttl = ttl or -1,
    count = count or -1,
    immunity_delay = immunity_delay or -1,
    file_type = {
      tdLua = 'fileType' .. file_type
    },
    chat_ids = tdLua_function.vectorize(chat_ids),
    exclude_chat_ids = tdLua_function.vectorize(exclude_chat_ids),
    chat_limit = chat_limit
  }
end
function tdLua_function.setNetworkType(type)
  return function_core.run_table{
    tdLua = 'setNetworkType',
    type = {
      tdLua = 'networkType' .. type
    },
  }
end
function tdLua_function.getNetworkStatistics(only_current)
  return function_core.run_table{
    tdLua = 'getNetworkStatistics',
    only_current = only_current
  }
end
function tdLua_function.addNetworkStatistics(entry, file_type, network_type, sent_bytes, received_bytes, duration)
  local file_type = file_type or 'None'
  return function_core.run_table{
    tdLua = 'addNetworkStatistics',
    entry = {
      tdLua = 'networkStatisticsEntry' .. entry,
      file_type = {
        tdLua = 'fileType' .. file_type
      },
      network_type = {
        tdLua = 'networkType' .. network_type
      },
      sent_bytes = sent_bytes,
      received_bytes = received_bytes,
      duration = duration
    }
  }
end
function tdLua_function.resetNetworkStatistics()
  return function_core.run_table{
    tdLua = 'resetNetworkStatistics'
  }
end
function tdLua_function.getCountryCode()
  return function_core.run_table{
    tdLua = 'getCountryCode'
  }
end
function tdLua_function.getInviteText()
  return function_core.run_table{
    tdLua = 'getInviteText'
  }
end
function tdLua_function.getTermsOfService()
  return function_core.run_table{
    tdLua = 'getTermsOfService'
  }
end
function tdLua_function.sendText(chat_id, reply_to_message_id, text, parse_mode, disable_web_page_preview, clear_draft, disable_notification, from_background, reply_markup)
  local input_message_content = {
    tdLua = 'inputMessageText',
    disable_web_page_preview = disable_web_page_preview,
    text = {text = text},
    clear_draft = clear_draft
  }
  return tdLua_function.sendMessage(chat_id, reply_to_message_id, input_message_content, parse_mode, disable_notification, from_background, reply_markup)
end
function tdLua_function.sendAnimation(chat_id, reply_to_message_id, animation, caption, parse_mode, duration, width, height, thumbnail, thumb_width, thumb_height, disable_notification, from_background, reply_markup)
  local input_message_content = {
    tdLua = 'inputMessageAnimation',
    animation = tdLua_function.getInputFile(animation),
    thumbnail = {
      tdLua = 'inputThumbnail',
      thumbnail = tdLua_function.getInputFile(thumbnail),
      width = thumb_width,
      height = thumb_height
    },
    caption = {text = caption},
    duration = duration,
    width = width,
    height = height
  }
  return tdLua_function.sendMessage(chat_id, reply_to_message_id, input_message_content, parse_mode, disable_notification, from_background, reply_markup)
end
function tdLua_function.sendAudio(chat_id, reply_to_message_id, audio, caption, parse_mode, duration, title, performer, thumbnail, thumb_width, thumb_height, disable_notification, from_background, reply_markup)
  local input_message_content = {
    tdLua = 'inputMessageAudio',
    audio = tdLua_function.getInputFile(audio),
    album_cover_thumbnail = {
      tdLua = 'inputThumbnail',
      thumbnail = tdLua_function.getInputFile(thumbnail),
      width = thumb_width,
      height = thumb_height
    },
    caption = {text = caption},
    duration = duration,
    title = tostring(title),
    performer = tostring(performer)
  }
  return tdLua_function.sendMessage(chat_id, reply_to_message_id, input_message_content, parse_mode, disable_notification, from_background, reply_markup)
end
function tdLua_function.sendDocument(chat_id, reply_to_message_id, document, caption, parse_mode, thumbnail, thumb_width, thumb_height, disable_notification, from_background, reply_markup)
  local input_message_content = {
    tdLua = 'inputMessageDocument',
    document = tdLua_function.getInputFile(document),
    thumbnail = {
      tdLua = 'inputThumbnail',
      thumbnail = tdLua_function.getInputFile(thumbnail),
      width = thumb_width,
      height = thumb_height
    },
    caption = {text = caption}
  }
  return tdLua_function.sendMessage(chat_id, reply_to_message_id, input_message_content, parse_mode, disable_notification, from_background, reply_markup)
end
function tdLua_function.sendPhoto(chat_id, reply_to_message_id, photo, caption, parse_mode, added_sticker_file_ids, width, height, ttl, thumbnail, thumb_width, thumb_height, disable_notification, from_background, reply_markup)
  local input_message_content = {
    tdLua = 'inputMessagePhoto',
    photo = tdLua_function.getInputFile(photo),
    thumbnail = {
      tdLua = 'inputThumbnail',
      thumbnail = tdLua_function.getInputFile(thumbnail),
      width = thumb_width,
      height = thumb_height
    },
    caption = {text = caption},
    added_sticker_file_ids = tdLua_function.vectorize(added_sticker_file_ids),
    width = width,
    height = height,
    ttl = ttl or 0
  }
  return tdLua_function.sendMessage(chat_id, reply_to_message_id, input_message_content, parse_mode, disable_notification, from_background, reply_markup)
end
function tdLua_function.sendSticker(chat_id, reply_to_message_id, sticker, width, height, disable_notification, thumbnail, thumb_width, thumb_height, from_background, reply_markup)
  local input_message_content = {
    tdLua = 'inputMessageSticker',
    sticker = tdLua_function.getInputFile(sticker),
    thumbnail = {
      tdLua = 'inputThumbnail',
      thumbnail = tdLua_function.getInputFile(thumbnail),
      width = thumb_width,
      height = thumb_height
    },
    width = width,
    height = height
  }
  return tdLua_function.sendMessage(chat_id, reply_to_message_id, input_message_content, nil, disable_notification, from_background, reply_markup)
end
function tdLua_function.sendVideo(chat_id, reply_to_message_id, video, caption, parse_mode, added_sticker_file_ids, duration, width, height, ttl, thumbnail, thumb_width, thumb_height, disable_notification, from_background, reply_markup)
  local input_message_content = {
    tdLua = 'inputMessageVideo',
    video = tdLua_function.getInputFile(video),
    thumbnail = {
      tdLua = 'inputThumbnail',
      thumbnail = tdLua_function.getInputFile(thumbnail),
      width = thumb_width,
      height = thumb_height
    },
    caption = {text = caption},
    added_sticker_file_ids = tdLua_function.vectorize(added_sticker_file_ids),
    duration = duration,
    width = width,
    height = height,
    ttl = ttl
  }
  return tdLua_function.sendMessage(chat_id, reply_to_message_id, input_message_content, parse_mode, disable_notification, from_background, reply_markup)
end
function tdLua_function.sendVideoNote(chat_id, reply_to_message_id, video_note, duration, length, thumbnail, thumb_width, thumb_height, disable_notification, from_background, reply_markup)
  local input_message_content = {
    tdLua = 'inputMessageVideoNote',
    video_note = tdLua_function.getInputFile(video_note),
    thumbnail = {
      tdLua = 'inputThumbnail',
      thumbnail = tdLua_function.getInputFile(thumbnail),
      width = thumb_width,
      height = thumb_height
    },
    duration = duration,
    length = length
  }
  return tdLua_function.sendMessage(chat_id, reply_to_message_id, input_message_content, nil, disable_notification, from_background, reply_markup)
end
function tdLua_function.sendVoiceNote(chat_id, reply_to_message_id, voice_note, caption, parse_mode, duration, waveform, disable_notification, from_background, reply_markup)
  local input_message_content = {
    tdLua = 'inputMessageVoiceNote',
    voice_note = tdLua_function.getInputFile(voice_note),
    caption = {text = caption},
    duration = duration,
    waveform = waveform
  }
  return tdLua_function.sendMessage(chat_id, reply_to_message_id, input_message_content, parse_mode, disable_notification, from_background, reply_markup)
end
function tdLua_function.sendLocation(chat_id, reply_to_message_id, latitude, longitude, disable_notification, from_background, reply_markup)
  local input_message_content = {
    tdLua = 'inputMessageLocation',
    location = {
      tdLua = 'location',
      latitude = latitude,
      longitude = longitude
    },
    live_period = liveperiod
  }
  return tdLua_function.sendMessage(chat_id, reply_to_message_id, input_message_content, nil, disable_notification, from_background, reply_markup)
end
function tdLua_function.sendVenue(chat_id, reply_to_message_id, latitude, longitude, title, address, provider, id, disable_notification, from_background, reply_markup)
  local input_message_content = {
    tdLua = 'inputMessageVenue',
    venue = {
      tdLua = 'venue',
      location = {
        tdLua = 'location',
        latitude = latitude,
        longitude = longitude
      },
      title = tostring(title),
      address = tostring(address),
      provider = tostring(provider),
      id = tostring(id)
    }
  }
  return tdLua_function.sendMessage(chat_id, reply_to_message_id, input_message_content, nil, disable_notification, from_background, reply_markup)
end
function tdLua_function.sendContact(chat_id, reply_to_message_id, phone_number, first_name, last_name, user_id, disable_notification, from_background, reply_markup)
  local input_message_content = {
    tdLua = 'inputMessageContact',
    contact = {
      tdLua = 'contact',
      phone_number = tostring(phone_number),
      first_name = tostring(first_name),
      last_name = tostring(last_name),
      user_id = user_id
    }
  }
  return tdLua_function.sendMessage(chat_id, reply_to_message_id, input_message_content, nil, disable_notification, from_background, reply_markup)
end
function tdLua_function.sendInvoice(chat_id, reply_to_message_id, invoice, title, description, photo_url, photo_size, photo_width, photo_height, payload, provider_token, provider_data, start_parameter, disable_notification, from_background, reply_markup)
  local input_message_content = {
    tdLua = 'inputMessageInvoice',
    invoice = invoice,
    title = tostring(title),
    description = tostring(description),
    photo_url = tostring(photo_url),
    photo_size = photo_size,
    photo_width = photo_width,
    photo_height = photo_height,
    payload = payload,
    provider_token = tostring(provider_token),
    provider_data = tostring(provider_data),
    start_parameter = tostring(start_parameter)
  }
  return tdLua_function.sendMessage(chat_id, reply_to_message_id, input_message_content, nil, disable_notification, from_background, reply_markup)
end
function tdLua_function.sendForwarded(chat_id, reply_to_message_id, from_chat_id, message_id, in_game_share, disable_notification, from_background, reply_markup)
  local input_message_content = {
    tdLua = 'inputMessageForwarded',
    from_chat_id = from_chat_id,
    message_id = message_id,
    in_game_share = in_game_share
  }
  return tdLua_function.sendMessage(chat_id, reply_to_message_id, input_message_content, nil, disable_notification, from_background, reply_markup)
end
function tdLua_function.sendPoll(chat_id, reply_to_message_id, question, options, pollType, is_anonymous, allow_multiple_answers)
  local input_message_content = {
      tdLua = 'inputMessagePoll',
      is_anonymous = is_anonymous,
      question = question,
      type = {
        tdLua = 'pollType'..pollType,
        allow_multiple_answers = allow_multiple_answers
      },
      options = options
    }
  return tdLua_function.sendMessage(chat_id, reply_to_message_id, input_message_content, parse_mode, disable_notification, from_background, reply_markup)
end
function tdLua_function.getPollVoters(chat_id, message_id, option_id, offset, limit)
  return function_core.run_table{
    tdLua = 'getPollVoters',
    chat_id = chat_id,
    message_id = message_id,
    option_id = option_id,
    limit = tdLua_function.setLimit(50 , limit),
    offset = offset
  }
end
function tdLua_function.setPollAnswer(chat_id, message_id, option_ids)
  return function_core.run_table{
    tdLua = 'setPollAnswer',
    chat_id = chat_id,
    message_id = message_id,
    option_ids = option_ids
  }
end
function tdLua_function.stopPoll(chat_id, message_id, reply_markup)
  return function_core.run_table{
    tdLua = 'stopPoll',
    chat_id = chat_id,
    message_id = message_id,
    reply_markup = reply_markup
  }
end
function tdLua_function.getInputMessage(value)
  if type(value) ~= 'table' then
    return value
  end
  if type(value.type) == 'string' then
    if value.parse_mode and value.caption then
      caption = tdLua_function.parseTextEntities(value.caption, value.parse_mode)
    elseif value.caption and not value.parse_mode then
      caption = {
        text = value.caption
      }
    elseif value.parse_mode and value.text then
      text = tdLua_function.parseTextEntities(value.text, value.parse_mode)
    elseif not value.parse_mode and value.text then
      text = {
        text = value.text
      }
    end
    value.type = string.lower(value.type)
    if value.type == 'text' then
      return {
        tdLua = 'inputMessageText',
        disable_web_page_preview = value.disable_web_page_preview,
        text = text,
        clear_draft = value.clear_draft
      }
    elseif value.type == 'animation' then
      return {
        tdLua = 'inputMessageAnimation',
        animation = tdLua_function.getInputFile(value.animation),
        thumbnail = {
          tdLua = 'inputThumbnail',
          thumbnail = tdLua_function.getInputFile(value.thumbnail),
          width = value.thumb_width,
          height = value.thumb_height
        },
        caption = caption,
        duration = value.duration,
        width = value.width,
        height = value.height
      }
    elseif value.type == 'audio' then
      return {
        tdLua = 'inputMessageAudio',
        audio = tdLua_function.getInputFile(value.audio),
        album_cover_thumbnail = {
          tdLua = 'inputThumbnail',
          thumbnail = tdLua_function.getInputFile(value.thumbnail),
          width = value.thumb_width,
          height = value.thumb_height
        },
        caption = caption,
        duration = value.duration,
        title = tostring(value.title),
        performer = tostring(value.performer)
      }
    elseif value.type == 'document' then
      return {
        tdLua = 'inputMessageDocument',
        document = tdLua_function.getInputFile(value.document),
        thumbnail = {
          tdLua = 'inputThumbnail',
          thumbnail = tdLua_function.getInputFile(value.thumbnail),
          width = value.thumb_width,
          height = value.thumb_height
        },
        caption = caption
      }
    elseif value.type == 'photo' then
      return {
        tdLua = 'inputMessagePhoto',
        photo = tdLua_function.getInputFile(value.photo),
        thumbnail = {
          tdLua = 'inputThumbnail',
          thumbnail = tdLua_function.getInputFile(value.thumbnail),
          width = value.thumb_width,
          height = value.thumb_height
        },
        caption = caption,
        added_sticker_file_ids = tdLua_function.vectorize(value.added_sticker_file_ids),
        width = value.width,
        height = value.height,
        ttl = value.ttl or 0
      }
    elseif value.text == 'video' then
      return {
        tdLua = 'inputMessageVideo',
        video = tdLua_function.getInputFile(value.video),
        thumbnail = {
          tdLua = 'inputThumbnail',
          thumbnail = tdLua_function.getInputFile(value.thumbnail),
          width = value.thumb_width,
          height = value.thumb_height
        },
        caption = caption,
        added_sticker_file_ids = tdLua_function.vectorize(value.added_sticker_file_ids),
        duration = value.duration,
        width = value.width,
        height = value.height,
        ttl = value.ttl or 0
      }
    elseif value.text == 'videonote' then
      return {
        tdLua = 'inputMessageVideoNote',
        video_note = tdLua_function.getInputFile(value.video_note),
        thumbnail = {
          tdLua = 'inputThumbnail',
          thumbnail = tdLua_function.getInputFile(value.thumbnail),
          width = value.thumb_width,
          height = value.thumb_height
        },
        duration = value.duration,
        length = value.length
      }
    elseif value.text == 'voice' then
      return {
        tdLua = 'inputMessageVoiceNote',
        voice_note = tdLua_function.getInputFile(value.voice_note),
        caption = caption,
        duration = value.duration,
        waveform = value.waveform
      }
    elseif value.text == 'location' then
      return {
        tdLua = 'inputMessageLocation',
        location = {
          tdLua = 'location',
          latitude = value.latitude,
          longitude = value.longitude
        },
        live_period = value.liveperiod
      }
    elseif value.text == 'contact' then
      return {
        tdLua = 'inputMessageContact',
        contact = {
          tdLua = 'contact',
          phone_number = tostring(value.phone_number),
          first_name = tostring(value.first_name),
          last_name = tostring(value.last_name),
          user_id = value.user_id
        }
      }
    elseif value.text == 'contact' then
      return {
        tdLua = 'inputMessageContact',
        contact = {
          tdLua = 'contact',
          phone_number = tostring(value.phone_number),
          first_name = tostring(value.first_name),
          last_name = tostring(value.last_name),
          user_id = value.user_id
        }
      }
    end
  end
end
function tdLua_function.editInlineMessageText(inline_message_id, input_message_content, reply_markup)
  return function_core.run_table{
    tdLua = 'editInlineMessageText',
    input_message_content = tdLua_function.getInputMessage(input_message_content),
    reply_markup = reply_markup
  }
end
function tdLua_function.answerInlineQuery(inline_query_id, results, next_offset, switch_pm_text, switch_pm_parameter, is_personal, cache_time)
  local answerInlineQueryResults = {}
  for key, value in pairs(results) do
    local newAnswerInlineQueryResults_id = #answerInlineQueryResults + 1
    if type(value) == 'table' and type(value.type) == 'string' then
      value.type = string.lower(value.type)
      if value.type == 'gif' then
        answerInlineQueryResults[newAnswerInlineQueryResults_id] = {
          tdLua = 'inputInlineQueryResultAnimatedGif',
          id = value.id,
          title = value.title,
          thumbnail_url = value.thumbnail_url,
          gif_url = value.gif_url,
          gif_duration = value.gif_duration,
          gif_width = value.gif_width,
          gif_height = value.gif_height,
          reply_markup = tdLua_function.replyMarkup{
            type = 'inline',
            data = value.reply_markup
          },
          input_message_content = tdLua_function.getInputMessage(value.input)
        }
      elseif value.type == 'mpeg4' then
        answerInlineQueryResults[newAnswerInlineQueryResults_id] = {
          tdLua = 'inputInlineQueryResultAnimatedMpeg4',
          id = value.id,
          title = value.title,
          thumbnail_url = value.thumbnail_url,
          mpeg4_url = value.mpeg4_url,
          mpeg4_duration = value.mpeg4_duration,
          mpeg4_width = value.mpeg4_width,
          mpeg4_height = value.mpeg4_height,
          reply_markup = tdLua_function.replyMarkup{
            type = 'inline',
            data = value.reply_markup
          },
          input_message_content = tdLua_function.getInputMessage(value.input)
        }
      elseif value.type == 'article' then
        answerInlineQueryResults[newAnswerInlineQueryResults_id] = {
          tdLua = 'inputInlineQueryResultArticle',
          id = value.id,
          url = value.url,
          hide_url = value.hide_url,
          title = value.title,
          description = value.description,
          thumbnail_url = value.thumbnail_url,
          thumbnail_width = value.thumbnail_width,
          thumbnail_height = value.thumbnail_height,
          reply_markup = tdLua_function.replyMarkup{
            type = 'inline',
            data = value.reply_markup
          },
          input_message_content = tdLua_function.getInputMessage(value.input)
        }
      elseif value.type == 'audio' then
        answerInlineQueryResults[newAnswerInlineQueryResults_id] = {
          tdLua = 'inputInlineQueryResultAudio',
          id = value.id,
          title = value.title,
          performer = value.performer,
          audio_url = value.audio_url,
          audio_duration = value.audio_duration,
          reply_markup = tdLua_function.replyMarkup{
            type = 'inline',
            data = value.reply_markup
          },
          input_message_content = tdLua_function.getInputMessage(value.input)
        }
      elseif value.type == 'contact' then
        answerInlineQueryResults[newAnswerInlineQueryResults_id] = {
          tdLua = 'inputInlineQueryResultContact',
          id = value.id,
          contact = value.contact,
          thumbnail_url = value.thumbnail_url,
          thumbnail_width = value.thumbnail_width,
          thumbnail_height = thumbnail_height.description,
          reply_markup = tdLua_function.replyMarkup{
            type = 'inline',
            data = value.reply_markup
          },
          input_message_content = tdLua_function.getInputMessage(value.input)
        }
      elseif value.type == 'document' then
        answerInlineQueryResults[newAnswerInlineQueryResults_id] = {
          tdLua = 'inputInlineQueryResultDocument',
          id = value.id,
          title = value.title,
          description = value.description,
          document_url = value.document_url,
          mime_type = value.mime_type,
          thumbnail_url = value.thumbnail_url,
          thumbnail_width = value.thumbnail_width,
          thumbnail_height = value.thumbnail_height,
          reply_markup = tdLua_function.replyMarkup{
            type = 'inline',
            data = value.reply_markup
          },
          input_message_content = tdLua_function.getInputMessage(value.input)
        }
      elseif value.type == 'game' then
        answerInlineQueryResults[newAnswerInlineQueryResults_id] = {
          tdLua = 'inputInlineQueryResultGame',
          id = value.id,
          game_short_name = value.game_short_name,
          reply_markup = tdLua_function.replyMarkup{
            type = 'inline',
            data = value.reply_markup
          },
          input_message_content = tdLua_function.getInputMessage(value.input)
        }
      elseif value.type == 'location' then
        answerInlineQueryResults[newAnswerInlineQueryResults_id] = {
          tdLua = 'inputInlineQueryResultLocation',
          id = value.id,
          location = value.location,
          live_period = value.live_period,
          title = value.title,
          thumbnail_url = value.thumbnail_url,
          thumbnail_width = value.thumbnail_width,
          thumbnail_height = value.thumbnail_height,
          reply_markup = tdLua_function.replyMarkup{
            type = 'inline',
            data = value.reply_markup
          },
          input_message_content = tdLua_function.getInputMessage(value.input)
        }
      elseif value.type == 'photo' then
        answerInlineQueryResults[newAnswerInlineQueryResults_id] = {
          tdLua = 'inputInlineQueryResultPhoto',
          id = value.id,
          title = value.title,
          description = value.description,
          thumbnail_url = value.thumbnail_url,
          photo_url = value.photo_url,
          photo_width = value.photo_width,
          photo_height = value.photo_height,
          reply_markup = tdLua_function.replyMarkup{
            type = 'inline',
            data = value.reply_markup
          },
          input_message_content = tdLua_function.getInputMessage(value.input)
        }
      elseif value.type == 'sticker' then
        answerInlineQueryResults[newAnswerInlineQueryResults_id] = {
          tdLua = 'inputInlineQueryResultSticker',
          id = value.id,
          thumbnail_url = value.thumbnail_url,
          sticker_url = value.sticker_url,
          sticker_width = value.sticker_width,
          sticker_height = value.sticker_height,
          photo_width = value.photo_width,
          photo_height = value.photo_height,
          reply_markup = tdLua_function.replyMarkup{
            type = 'inline',
            data = value.reply_markup
          },
          input_message_content = tdLua_function.getInputMessage(value.input)
        }
      elseif value.type == 'sticker' then
        answerInlineQueryResults[newAnswerInlineQueryResults_id] = {
          tdLua = 'inputInlineQueryResultSticker',
          id = value.id,
          thumbnail_url = value.thumbnail_url,
          sticker_url = value.sticker_url,
          sticker_width = value.sticker_width,
          sticker_height = value.sticker_height,
          photo_width = value.photo_width,
          photo_height = value.photo_height,
          reply_markup = tdLua_function.replyMarkup{
            type = 'inline',
            data = value.reply_markup
          },
          input_message_content = tdLua_function.getInputMessage(value.input)
        }
      elseif value.type == 'video' then
        answerInlineQueryResults[newAnswerInlineQueryResults_id] = {
          tdLua = 'inputInlineQueryResultVideo',
          id = value.id,
          title = value.title,
          description = value.description,
          thumbnail_url = value.thumbnail_url,
          video_url = value.video_url,
          mime_type = value.mime_type,
          video_width = value.video_width,
          video_height = value.video_height,
          video_duration = value.video_duration,
          reply_markup = tdLua_function.replyMarkup{
            type = 'inline',
            data = value.reply_markup
          },
          input_message_content = tdLua_function.getInputMessage(value.input)
        }
      elseif value.type == 'videonote' then
        answerInlineQueryResults[newAnswerInlineQueryResults_id] = {
          tdLua = 'inputInlineQueryResultVoiceNote',
          id = value.id,
          title = value.title,
          voice_note_url = value.voice_note_url,
          voice_note_duration = value.voice_note_duration,
          reply_markup = tdLua_function.replyMarkup{
            type = 'inline',
            data = value.reply_markup
          },
          input_message_content = tdLua_function.getInputMessage(value.input)
        }
      end
    end
  end
  return function_core.run_table{
    tdLua = 'answerInlineQuery',
    inline_query_id = inline_query_id,
    next_offset = next_offset,
    switch_pm_text = switch_pm_text,
    switch_pm_parameter = switch_pm_parameter,
    is_personal = is_personal,
    cache_time = cache_time,
    results = answerInlineQueryResults,
  }
end
function tdLua.VERSION()
  print(tdLua_function.colors('%{yellow}\27[5m'..tdLua.logo))
  return true
end
function tdLua.run(main_def, filters)
  if type(main_def) ~= 'function' then
    function_core.print_error('the run main_def must be a main function !')
    os.exit(1)
  else
    update_functions[0] = {}
    update_functions[0].def = main_def
    update_functions[0].filters = filters
  end
  while tdLua.get_update do
    for timer_id, timer_data in pairs(tdLua_timer) do
      if os.time() >= timer_data.run_in then
        xpcall(timer_data.def, function_core.print_error,timer_data.argv)
        table.remove(tdLua_timer,timer_id)
      end
    end
    local update = function_core.change_table(client:get(1))
    if update then
      if type(update) ~= 'table' then
          goto finish
      end
      if tdLua.login(update) then
        function_core._CALL_(update)
      end
    end
    ::finish::
  end
end
function tdLua.set_config(data)
  tdLua.VERSION()
  if not data.api_hash then
    print(tdLua_function.colors('%{red} please use api_hash in your script !'))
    os.exit()
  end
  if not data.api_id then
    print(tdLua_function.colors('%{red} please use api_id in your script !'))
    os.exit()
  end
  if not data.session_name then
    print(tdLua_function.colors('%{red} please use session_name in your script !'))
    os.exit()
  end
  if not data.token and not tdLua_function.exists('.tdLua-sessions/'..data.session_name) then
    io.write(tdLua_function.colors('\n%{green} please use your token or phone number > '))
    local phone_token = io.read()
    if phone_token:match('%d+:') then
      tdLua.config.is_bot = true
      tdLua.config.token = phone_token
    else
      tdLua.config.is_bot = false
      tdLua.config.phone = phone_token
    end
  elseif data.token and not tdLua_function.exists('.tdLua-sessions/'..data.session_name) then
    tdLua.config.is_bot = true
    tdLua.config.token = data.token
  end
  if not tdLua_function.exists('.tdLua-sessions') then
    os.execute('sudo mkdir .tdLua-sessions')
  end
  tdLua.config.encryption_key = data.encryption_key or ''
  tdLua.config.parameters = {
    tdLua = 'setTdlibParameters',
    use_message_database = data.use_message_database or true,
    api_id = data.api_id,
    api_hash = data.api_hash,
    use_secret_chats = use_secret_chats or true,
    system_language_code = data.language_code or 'en',
    device_model = data.device_model or 'tdLua',
    system_version = data.system_version or 'linux',
    application_version = data.app_version or '1.0',
    enable_storage_optimizer = data.enable_storage_optimizer or true,
    use_pfs = data.use_pfs or true,
    database_directory = '.tdLua-sessions/'..data.session_name
  }
  return tdLua_function
end
function tdLua.login(state)
  if state.name == 'version' and state.value and state.value.value then
    print(tdLua_function.colors('%{magenta}TDLIB VERSION : '..state.value.value),'\n\n')
  elseif state.authorization_state and state.authorization_state.tdLua == 'error' and (state.authorization_state.message == 'PHONE_NUMBER_INVALID' or state.authorization_state.message == 'ACCESS_TOKEN_INVALID') then
    if state.authorization_state.message == 'PHONE_NUMBER_INVALID' then
      print(tdLua_function.colors('%{red} phone number invalid !'))
    else
      print(tdLua_function.colors('%{red} access token invalid !'))
    end
    io.write(tdLua_function.colors('\n%{green} please use your token or phone number > '))
    local phone_token = io.read()
    if phone_token:match('%d+:') then
      function_core.send_tdlib{
        tdLua = 'checkAuthenticationBotToken',
        token = phone_token
      }
    else
      function_core.send_tdlib{
        tdLua = 'setAuthenticationPhoneNumber',
        phone_number = phone_token
      }
    end
  elseif state.authorization_state and state.authorization_state.tdLua == 'error' and state.authorization_state.message == 'PHONE_CODE_INVALID' then
    io.write(tdLua_function.colors('\n%{green} code > '))
    local code = io.read()
    function_core.send_tdlib{
      tdLua = 'checkAuthenticationCode',
      code = code
    }
  elseif state.authorization_state and state.authorization_state.tdLua == 'error' and state.authorization_state.message == 'PASSWORD_HASH_INVALID' then
    print(tdLua_function.colors('%{red}two-step is wrong !'))
    io.write(tdLua_function.colors('\n%{green} password > '))
    local password = io.read()
    function_core.send_tdlib{
      tdLua = 'checkAuthenticationPassword',
      password = password
    }
  elseif state.tdLua == 'authorizationStateWaitTdlibParameters' or (state.authorization_state and state.authorization_state.tdLua == 'authorizationStateWaitTdlibParameters') then
    function_core.send_tdlib{
      tdLua = 'setTdlibParameters',
      parameters = tdLua.config.parameters
    }
  elseif state.authorization_state and state.authorization_state.tdLua == 'authorizationStateWaitEncryptionKey' then
    function_core.send_tdlib{
      tdLua = 'checkDatabaseEncryptionKey',
      encryption_key = tdLua.config.encryption_key
    }
  elseif state.authorization_state and state.authorization_state.tdLua == 'authorizationStateWaitPhoneNumber' then
    if tdLua.config.is_bot then
      function_core.send_tdlib{
        tdLua = 'checkAuthenticationBotToken',
        token = tdLua.config.token
      }
    else
      function_core.send_tdlib{
        tdLua = 'setAuthenticationPhoneNumber',
        phone_number = tdLua.config.phone
      }
    end
  elseif state.authorization_state and state.authorization_state.tdLua == 'authorizationStateWaitCode' then
      io.write(tdLua_function.colors('\n%{green} code > '))
      local code = io.read()
      function_core.send_tdlib{
        tdLua = 'checkAuthenticationCode',
        code = code
      }
  elseif state.authorization_state and state.authorization_state.tdLua == 'authorizationStateWaitPassword' then
      io.write(tdLua_function.colors('\n%{green} password [ '..state.authorization_state.password_hint..' ] > '))
      local password = io.read()
      function_core.send_tdlib{
        tdLua = 'checkAuthenticationPassword',
        password = password
      }
  elseif state.authorization_state and state.authorization_state.tdLua == 'authorizationStateWaitRegistration' then
    io.write(tdLua_function.colors('\n%{green} first name > '))
    local first_name = io.read()
    io.write(tdLua_function.colors('\n%{green} last name > '))
    local last_name = io.read()
    function_core.send_tdlib{
      tdLua = 'registerUser',
      first_name = first_name,
      last_name = last_name
    }
  elseif state.authorization_state and state.authorization_state.tdLua == 'authorizationStateReady' then
    print(tdLua_function.colors("%{green}>> login successfully let's rock <<"))
  elseif state.authorization_state and state.authorization_state.tdLua == 'authorizationStateClosed' then
    print(tdLua_function.colors('%{red}>> authorization state closed '))
    tdLua.get_update = false
  elseif state.tdLua == 'error' and state.message then
    print(tdLua_function.colors('%{red}>> '..state.message))
  elseif not (state.tdLua and tdLua_function.in_array({'updateConnectionState', 'updateSelectedBackground', 'updateConnectionState', 'updateOption', 'ok',}, state.tdLua)) then
    return true
  end
end
return tdLua
