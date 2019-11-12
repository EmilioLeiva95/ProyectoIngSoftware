package com.persistent.bean;

import javax.faces.application.FacesMessage;
import javax.faces.bean.ManagedBean;
import javax.faces.context.FacesContext;

import com.persistent.dao.UsuarioDao;
import com.persistent.bean.Functions;

@ManagedBean
public class Login {

	private boolean isLogin = false;
	private String user;
	private String pwd;

	public String validate() {
		System.out.println("Dentro de funcion validate " + user + " " + pwd);
		UsuarioDao data = new UsuarioDao();
		Functions f = new Functions();
		try {
			if (f.validateVoid(user) && f.validateVoid(pwd)) {
				if (data.validate(user, pwd))
					return "Main.xhtml?faces-redirect=true";
				else {
					addMessage("Usuario invalido");
					// return "";
				}
			} else {
				addMessage("Campo invalido");
				System.out.println("Campo invalido");
			}
		} catch (Exception e) {
			System.out.println("Ocurrio un error login : " + e.getMessage());
		}

		return "";
	}

	public void addMessage(String summary) {
		FacesMessage message = new FacesMessage(FacesMessage.SEVERITY_ERROR, summary, null);
		FacesContext.getCurrentInstance().addMessage(null, message);
	}

	public boolean isLogin() {
		return isLogin;
	}

	public void setLogin(boolean isLogin) {
		this.isLogin = isLogin;
	}

	public String getUser() {
		return user;
	}

	public void setUser(String usr) {
		this.user = usr;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

}
