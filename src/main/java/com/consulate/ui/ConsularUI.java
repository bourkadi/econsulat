package com.consulate.ui;

import javax.servlet.annotation.WebServlet;

import com.consulate.ui.login.AccessControl;
import com.consulate.ui.login.BasicAccessControl;
import com.consulate.ui.login.LoginScreen;
import com.consulate.ui.login.LoginScreen.LoginListener;
import com.vaadin.annotations.Theme;
import com.vaadin.annotations.VaadinServletConfiguration;
import com.vaadin.server.Responsive;
import com.vaadin.server.VaadinRequest;
import com.vaadin.server.VaadinServlet;
import com.vaadin.ui.UI;
import com.vaadin.ui.themes.ValoTheme;

@SuppressWarnings("serial")
@Theme("cabinets")
public class ConsularUI extends UI {

	@WebServlet(value = "/*", asyncSupported = true)
	@VaadinServletConfiguration(productionMode = false, ui = ConsularUI.class)
	public static class Servlet extends VaadinServlet {
	}

	private AccessControl accessControl = new BasicAccessControl();

	@Override
	protected void init(VaadinRequest request) {
		Responsive.makeResponsive(this);
		setLocale(request.getLocale());
		getPage().setTitle("Systeme de gestion consulaire");
		if (!accessControl.isUserSignedIn()) {
			setContent(new LoginScreen(accessControl, new LoginListener() {
				@Override
				public void loginSuccessful() {
					showMainView();
				}
			}));
		} else {
			showMainView();
		}
		// layout.addComponent(mainLayout);
	}

	protected void showMainView() {
		addStyleName(ValoTheme.UI_WITH_MENU);
		setContent(new MainScreen(ConsularUI.this));

		getNavigator().navigateTo(getNavigator().getState());
	}

}