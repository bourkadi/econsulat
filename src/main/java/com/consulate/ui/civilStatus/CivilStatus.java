package com.consulate.ui.civilStatus;

import com.vaadin.navigator.Navigator;
import com.vaadin.navigator.View;
import com.vaadin.navigator.ViewChangeListener.ViewChangeEvent;
import com.vaadin.server.ExternalResource;
import com.vaadin.ui.Button;
import com.vaadin.ui.Component;
import com.vaadin.ui.CssLayout;
import com.vaadin.ui.Label;
import com.vaadin.ui.Link;
import com.vaadin.ui.themes.Reindeer;
import com.vaadin.ui.themes.ValoTheme;
import com.vaadin.ui.Button.ClickEvent;
import com.vaadin.ui.Button.ClickListener;

public class CivilStatus extends CssLayout implements View {

	/**
	 * 
	 */
	private static final long serialVersionUID = 3595516609766343961L;
	public static final String NAME = "Etat Civil";
	public static final String URL = "Civil_Status";
	Navigator navigator;

	@Override
	public void enter(ViewChangeEvent event) {
		// TODO Auto-generated method stub

	}

	public CivilStatus() {
		super();
		// TODO Auto-generated constructor stub
		setSizeFull();
		Button buttonCN = new Button("Certificat de Naissance");
		Button buttonCD=new Button("Certificat de Deces");
		
		buttonCD.setStyleName(ValoTheme.BUTTON_LINK);
		buttonCN.setStyleName(ValoTheme.BUTTON_LINK);

		
		buttonCD.addClickListener(redirect(DeathStatus.class, DeathStatus.URL));
		buttonCN.addClickListener(redirect(BirthStatus.class,BirthStatus.URL));
		addComponent(buttonCN);
		addComponent(buttonCD);
	}

	public ClickListener redirect(Class claz, String url) {
		ClickListener clickListener = new ClickListener() {

			@Override
			public void buttonClick(ClickEvent event) {
				// TODO Auto-generated method stub
				navigator = getUI().getNavigator();
				navigator.addView(url, claz);
				navigator.navigateTo(url);
			}
		};
		return clickListener;
	}

	public void prestationsList() {
		Link link = new Link("Go to stackoverflow.com", new ExternalResource("https://stackoverflow.com/"));
	}

	public CivilStatus(Component... children) {
		super(children);
		// TODO Auto-generated constructor stub
	}

}
