package com.consulate.ui;

import com.vaadin.navigator.View;
import com.vaadin.navigator.ViewChangeListener.ViewChangeEvent;
import com.vaadin.ui.Component;
import com.vaadin.ui.CssLayout;
import com.vaadin.ui.Label;

public class CivilStatus extends CssLayout implements View {

	/**
	 * 
	 */
	private static final long serialVersionUID = 3595516609766343961L;
	public static final String NAME = "Etat Civil";
	public static final String URL = "Civil_Status";

	@Override
	public void enter(ViewChangeEvent event) {
		// TODO Auto-generated method stub

	}

	public CivilStatus() {
		super();
		// TODO Auto-generated constructor stub
		setSizeFull();
		Label label = new Label("Hello, nice to see you again");
		addComponent(label);
	}

	public CivilStatus(Component... children) {
		super(children);
		// TODO Auto-generated constructor stub
	}

}
