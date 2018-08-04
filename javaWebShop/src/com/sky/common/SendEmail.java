package com.sky.common;

import java.util.Date;
import java.util.Properties;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class SendEmail {

    public static final String HOST = "smtp.163.com";
    public static final String PROTOCOL = "smtp";   
   
    public static final String FROM = "zhangsan_email@163.com";//发件人的email
    public static final String PWD = "zhangsan163sqm";//发件人密码

    /**
     * 获取Session
     * @return
     */
    private static Session getSession() {
        Properties props = new Properties();
        props.put("mail.smtp.host", HOST);//设置服务器地址
        props.put("mail.store.protocol" , PROTOCOL);//设置协议
        props.put("mail.smtp.auth" , true);

        Authenticator authenticator = new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(FROM, PWD);
            }

        };
        Session session = Session.getDefaultInstance(props , authenticator);

        return session;
    }

    public static boolean send(String toEmail , String content) {
        Session session = getSession();
        session.setDebug(true);
        try {
        	Message msg = new MimeMessage(session);
            msg.setFrom(new InternetAddress(FROM));
            
            msg.addRecipient(Message.RecipientType.TO,new InternetAddress(toEmail));
            msg.setSubject("账号激活邮件");
            msg.setSentDate(new Date());
            msg.setContent(content , "text/html;charset=utf-8");
            
            //Send the message
            Transport.send(msg);
            return true;
        }
        catch (MessagingException mex) {
            mex.printStackTrace();
            return false;
        }
    }
}