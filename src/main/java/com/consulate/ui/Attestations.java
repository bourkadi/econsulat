package com.consulate.ui;

import com.vaadin.navigator.View;
import com.vaadin.navigator.ViewChangeListener.ViewChangeEvent;
import com.vaadin.ui.Component;
import com.vaadin.ui.CssLayout;
import com.vaadin.ui.Label;

public class Attestations extends CssLayout implements View {

	/**
	 * 
	 */
	private static final long serialVersionUID = 3250186990773167319L;
	public static final String NAME = "Attestations";
	public static final String URL = "Attestations";

	@Override
	public void enter(ViewChangeEvent event) {
		// TODO Auto-generated method stub
		
	}

	public Attestations() {
		super();
		// TODO Auto-generated constructor stub
		setSizeFull();
		Label label = new Label("Some Attestations for Malika");
		addComponent(label);
	}

	public Attestations(Component... children) {
		super(children);
		// TODO Auto-generated constructor stub
	}

}
