package com.consulate.dao;

import java.io.Serializable;
import java.util.List;

import org.apache.logging.log4j.Level;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;


public class Dao implements DaoService, Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 4856408414787620256L;
	/**
	 * 
	 */
	private static Logger logger = LogManager.getLogger(Dao.class);
	private static Level VERBOSE = Level.forName("VERBOSE", 190);

	public <T> void save(final T o) {
		Transaction trns = null;
		Session session = HibernateUtils.getSessionFactory().openSession();

		try {
			trns = session.beginTransaction();
			logger.log(VERBOSE, "Trying to save object from " + o.getClass().getCanonicalName());
			session.saveOrUpdate(o);
			session.getTransaction().commit();
			logger.log(VERBOSE, "Object saved from " + o.getClass().getCanonicalName());

		} catch (RuntimeException e1) {
			if (trns != null) {
				logger.log(VERBOSE, "Object failed to be save of " + o.getClass().getCanonicalName());

				trns.rollback();
			}
			e1.printStackTrace();
		} finally {
			session.flush();
			session.close();
		}

	}

	public <T> void update(final T o) {
		Transaction trns = null;
		Session session = HibernateUtils.getSessionFactory().openSession();

		try {
			trns = session.beginTransaction();
			logger.log(VERBOSE, "Trying to save object from " + o.getClass().getCanonicalName());
			session.update(o);
			session.getTransaction().commit();
			logger.log(VERBOSE, "Object saved from " + o.getClass().getCanonicalName());

		} catch (RuntimeException e1) {
			if (trns != null) {
				logger.log(VERBOSE, "Object failed to be save of " + o.getClass().getCanonicalName());

				trns.rollback();
			}
			e1.printStackTrace();
		} finally {
			session.flush();
			session.close();
		}

	}

	public <T> List<T> getAll(final Class<T> type) {
		Session session = HibernateUtils.getSessionFactory().openSession();
		Transaction trns = null;
		trns = session.beginTransaction();
		final Criteria crit = session.createCriteria(type);
		List<T> list = null;
		try {

			list = crit.list();
			logger.log(VERBOSE, "Fetching objects from " + type.getClass().getCanonicalName());
			trns.commit();
		} catch (RuntimeException e1) {

			e1.printStackTrace();
		} finally {
			session.flush();
			session.close();
		}
		return list;
	}

	public <T> T get(final Class<T> type, final Integer id) {
		Transaction trns = null;
		Session session = HibernateUtils.getSessionFactory().openSession();
		T t = null;
		try {
			logger.log(VERBOSE,
					"Trying to get object from " + type.getClass().getCanonicalName() + " with identifier " + id);

			trns = session.beginTransaction();
			t = (T) session.get(type, id);
			session.getTransaction().commit();
			logger.log(VERBOSE, "Object fetched with success from " + type.getClass().getCanonicalName()
					+ " with identifier " + id);

		} catch (RuntimeException e1) {
			if (trns != null) {
				logger.log(VERBOSE,
						"Failed to get object from " + type.getClass().getCanonicalName() + " with identifier " + id);

				trns.rollback();
			}
			e1.printStackTrace();
		} finally {
			session.flush();
			session.close();
		}
		return t;

	}

	public <T> List<T> getByProperty(final Class<T> type, String propertyName, Object value) {
		Session session = HibernateUtils.getSessionFactory().openSession();
		List<T> list = null;
		try {
			final Criteria crit = session.createCriteria(type);
			crit.add(Restrictions.eq(propertyName, value));
			list = crit.list();
			logger.log(VERBOSE, "Trying to get object from " + type.getClass().getCanonicalName() + " with property "
					+ propertyName + " for the value " + value);
		} catch (RuntimeException e1) {
			e1.printStackTrace();
		} finally {
			session.flush();
			session.close();
		}
		return list;
	}

	public static void main(String[] args) {
		DaoService daoService = new Dao();
		Country uae= (Country)daoService.getByProperty(Country.class, "name", "uae").get(0);
		System.out.println(uae.getLongName());
		

	}
}
