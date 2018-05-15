package com.consulate.ui;

import com.consulate.ui.civilStatus.CivilStatus;
import com.vaadin.navigator.Navigator;
import com.vaadin.navigator.ViewChangeListener;
import com.vaadin.server.FontAwesome;
import com.vaadin.ui.CssLayout;
import com.vaadin.ui.HorizontalLayout;

public class MainScreen extends HorizontalLayout {
	private Menu menu;
	
	 public MainScreen(ConsularUI ui) {
		   setStyleName("main-screen");

	        CssLayout viewContainer = new CssLayout();
	        viewContainer.addStyleName("valo-content");
	        viewContainer.setSizeFull();
	
	        final Navigator navigator = new Navigator(ui, viewContainer);
	        navigator.setErrorView(ErrorView.class);

	        menu=new Menu(navigator);
	     //   menu.addView(AddClient.class,  AddClient.URL, AddClient.NAME, FontAwesome.PLUS);
	        menu.addView(CivilStatus.class, CivilStatus.URL, CivilStatus.NAME, FontAwesome.CIRCLE);
	        menu.addView(Attestations.class,  Attestations.URL, Attestations.NAME, FontAwesome.CIRCLE);
//	        menu.addView(Settings.class,  Settings.URL, Settings.NAME, FontAwesome.GEARS);

	        
	        navigator.addViewChangeListener(viewChangeListener);

	        addComponent(menu);
	        addComponent(viewContainer);
	        setExpandRatio(viewContainer, 1);
	        setSizeFull();
	 }
	// notify the view menu about view changes so that it can display which view
	    // is currently active
	    ViewChangeListener viewChangeListener = new ViewChangeListener() {

	        @Override
	        public boolean beforeViewChange(ViewChangeEvent event) {
	            return true;
	        }

	        @Override
	        public void afterViewChange(ViewChangeEvent event) {
	            menu.setActiveView(event.getViewName());
	        }

	    };
}
