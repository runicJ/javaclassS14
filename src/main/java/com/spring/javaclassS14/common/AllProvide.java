package com.spring.javaclassS14.common;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;

@Service
public class AllProvide {
	
	@Autowired
	JavaMailSender mailSender;
	
	// urlPath�� ���� �����ϴ� �޼ҵ�(���ε����ϸ�, ���������ϸ�, �����Ұ��)
	public void writeFile(MultipartFile fName, String sFileName, String urlPath) throws IOException {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/"+urlPath+"/");
		
		FileOutputStream fos = new FileOutputStream(realPath + sFileName);
		
		if(fName.getBytes().length != -1) {
			fos.write(fName.getBytes());
		}
		fos.flush();
		fos.close();
	}
	
	// ���� �̹��� ���� ����
	public void deleteFile(String user_image, String urlPath) {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/"+urlPath+"/");
		
		File file = new File(realPath + user_image);
		if(file.exists()) file.delete();
	}
	
	//���� �����ϱ�(���̵�ã��, ��й�ȣ ã��)
	public String mailSend(String toMail, String title, String pwd) throws MessagingException {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();  // �׳� ���� ���� ����ȯ �ؼ� request �����
		String content = "";
			
 		// ���� ������ ���� ��ü : MimeMessage(), MimeMessageHelper()  // ������, �ڿ� �߰��߰� �۾��Ѱ� �����ϴ� �����
		MimeMessage message = mailSender.createMimeMessage();
		MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");  // ���ڵ��ؼ� �׻� ����
 		
 		// ���Ϻ����Կ� �ۼ��� �޽������� ������ ��� �����Ų �� �۾�ó��...(3�� �ʿ��� �� �ؿ��� �ϳ��� ó����(�����϶�� �����)
 		messageHelper.setTo(toMail);  // �޴� ��� ���� �ּ� // �տ��� ���� ���� �ּҷ� �����ž�
 		messageHelper.setSubject(title);  // ���� ����  // �� setter�� �ִ� ��
 		messageHelper.setText(content);
 		
 		// �޽��� �������� ����(content)��, �߽����� �ʿ��� ������ �߰��� ��Ƽ� ����ó���Ѵ�.
		content = content.replace("\n", "<br>");  // �츮�� textarea�� ������ ������ ������ ������ text�� ��(���ٷ� ��µǱ⿡ �ٹٲ� ó�� ���ؼ� ù�� '=' ���)
		content += "<br><hr><h3> �ӽú�й�ȣ : "+pwd+"</h3><hr><br>";
		content += "<p><img src=\"cid:main.jpg\" width='500px'></p>";
		content += "<p>�湮�ϱ� : <a href='http://49.142.157.251:9090/cjgreen'>javaclass</a></p>";
		content += "<hr>";
		messageHelper.setText(content, true);  // ���� �� �����ϰ� �����ϰ� ����ġ����(������ 3�� �Ƚᵵ��)
 		
 		// ������ ����� �׸������� ��θ� ������ ǥ�ý����ش�. �׷��� �ٽ� �����Կ� �����Ѵ�.
		FileSystemResource file = new FileSystemResource(request.getSession().getServletContext().getRealPath("/resources/images/main.jpg"));
		messageHelper.addInline("main.jpg", file);
 		
 		// ���� �����ϱ�
		mailSender.send(message);
		
		return "1";
	}
}