package com.persistent.bean;

import java.util.regex.Pattern;


public class Functions {
	// Metodo que valida si una cadena esta vacia
	public boolean validateVoid(String text) {
		if (text != null && !text.equals(""))
			return true;
		return false;
	}

	// Metodo para validar cadena de password con un minimo de 8 caracteres y una
	// mayuscula, un numero,un caracter especial
	public boolean validatePass(String pwd) {
		String regex = "^(?=.*\\d)(?=.*[\\u0021-\\u002b\\u003c-\\u0040])(?=.*[A-Z])\\S{8,}$";
		if (Pattern.matches(regex, pwd))
			return true;

		return false;
	}



}
