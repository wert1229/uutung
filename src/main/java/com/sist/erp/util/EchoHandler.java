package com.sist.erp.util;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.google.gson.Gson;
import com.sist.erp.dao.ChatDAO;
import com.sist.erp.vo.ChatVO;

public class EchoHandler extends TextWebSocketHandler
{
	private static final Logger logger = LoggerFactory.getLogger(EchoHandler.class);
	
	private Map<String, WebSocketSession> sessionMap = new ConcurrentHashMap<>();
	
	@Autowired
	private ChatDAO chatDAO;
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		
		logger.info("{} 입장", session.getId());
	}
	
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		
		Gson gson = new Gson();
		
		String[] m = message.getPayload().split(":");
		
		if(m[0].equals("first")) {
			
			sessionMap.put(m[1], session);    //첫 입장일 때 MSEQ를 키로 session을 세션맵에 넣음
			
			return;
		}
		
		ChatVO chat = gson.fromJson(message.getPayload(), ChatVO.class);
		chatDAO.addChat(chat);
		
		String chatmsg = gson.toJson(chat);
		
		if(sessionMap.containsKey(chat.getReceiver())) { // 세션맵에서 특정 MSEQ를 찾아 대상에게 매세지 전송
			
			sessionMap.get(chat.getReceiver()).sendMessage(new TextMessage(chatmsg));
		}
	}
	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		
		for(String s : sessionMap.keySet()) {
			
			if(sessionMap.get(s)==session) {
				sessionMap.remove(s);
			}
		}
		
		logger.info("{} 퇴장", session.getId());
	}
}
