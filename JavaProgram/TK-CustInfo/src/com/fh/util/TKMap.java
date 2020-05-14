package com.fh.util;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.Set;

public class TKMap extends HashMap<String, Object> {


    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;



	/**
     * Get the value object associated with a key.
     *
     * @param key   A key string.
     * @return      The object associated with the key.
     * @throws   RuntimeException if the key is not found.
     */
    public Object req(String key) throws RuntimeException {
        Object o = get(key);
        if (o == null) {
            throw new RuntimeException("No key " + key + " in the map " + this + ".");
        }
        return o;
    }

    /**
     * Get the QgMap value associated with a key.
     *
     * @param key   A key string.
     * @return      The truth.
     * @throws   RuntimeException
     *  if the value is not a QgMap or doesn't exist.
     */
    public TKMap reqQgMap(String key) throws RuntimeException {
    	Object o = req(key);
        if (o instanceof TKMap) {
        	return (TKMap)o ;
        }
    	throw new RuntimeException("No key " + key + " in the map " + this + " is QgMap.");
    }

    /**
     * Get the Boolean value associated with a key.
     *
     * @param key   A key string.
     * @return      The truth.
     * @throws   RuntimeException
     *  if the value is not a Boolean or doesn't exist.
     */
    public Boolean reqBoolean(String key) throws RuntimeException {
        Object o = req(key);
        if (o.equals(Boolean.FALSE)) {
            return false;
        } else if (o.equals(Boolean.TRUE)) {
            return true;
        }
        throw new RuntimeException("No key " + key + " in the map " + this + " is Boolean.");
    }


    /**
     * Get the Double value associated with a key.
     * @param key   A key string.
     * @return      The Double value.
     * @throws RuntimeException if the key is not found or
     *  if the value is not a Double object.
     */
    public Double reqDouble(String key) throws RuntimeException {
        Object o = req(key);
        
        if (o instanceof Double) {
        	return (Double)o ;
        }else if(o instanceof BigDecimal){
        	return ((BigDecimal)o).doubleValue();
        }
        throw new RuntimeException("No key " + key + " in the map " + this + " is Double.");
    }


    /**
     * Get the Integer value associated with a key. If the number value is too
     * large for an Integer, it will be clipped.
     *
     * @param key   A key string.
     * @return      The integer value.
     * @throws   RuntimeException if the key is not found or if the value is not a Integer object.
     */
    public Integer reqInteger(String key) throws RuntimeException {
        Object o = req(key);
        if(o instanceof Integer) {
        	return (Integer)o;
        }
        throw new RuntimeException("No key " + key + " in the map " + this + " is Integer.");
    }

    

    /**
     * Get the Set value associated with a key.
     *
     * @param key   A key string.
     * @return      A Set which is the value.
     * @throws   RuntimeException if the key is not found or
     *  if the value is not a Set.
     */
	@SuppressWarnings("rawtypes")
	public Set reqSet(String key) throws RuntimeException {
        Object o = req(key);
        if (o instanceof Set) {
            return (Set)o;
        }
        throw new RuntimeException("No key " + key + " in the map " + this + " is Set.");
    }


    /**
     * Get the long value associated with a key. If the number value is too
     * long for a long, it will be clipped.
     *
     * @param key   A key string.
     * @return      The long value.
     * @throws   RuntimeException if the key is not found or if the value is not a Long object
     */
    public Long reqLong(String key) throws RuntimeException {
        Object o = req(key);
        if(o instanceof Long) {
        	return (Long)o;
        }
        throw new RuntimeException("No key " + key + " in the map " + this + " is Long.");
    }


    /**
     * Get the string associated with a key.
     *
     * @param key   A key string.
     * @return      A string which is the value.
     * @throws   RuntimeException if the key is not found or if the value is not a String object.
     */
    public String reqString(String key) throws RuntimeException {
    	Object o = req(key);
    	if(o instanceof String) {
    		return (String)o;
    	}
        return (String)o;
    }

    /**
     * Determine if the value associated with the key is null or if there is
     *  no value.
     * @param key   A key string.
     * @return      true if there is no value associated with the key or if the value is null.
     */
    public boolean isNull(String key) {
        return null == get(key);
    }

    /**
     * Get an optional qgMap associated with a key.
     * It returns null if there is no such key, or if the value is not
     * QgMap.
     *
     * @param key   A key string.
     * @return      The qgMap.
     */
    public TKMap getSfMap(String key) throws RuntimeException {
    	if (this.containsKey(key)) {
    		try {
				return this.reqQgMap(key);
			} catch (RuntimeException e) {
			}
    	}
        return null;
    }

    /**
     * Get an optional boolean associated with a key.
     * It returns null if there is no such key, or if the value is not
     * Boolean.TRUE or the String "true".
     *
     * @param key   A key string.
     * @return      The truth.
     */
    public Boolean getBoolean(String key) {
    	if (this.containsKey(key)) {
    		try {
				return this.reqBoolean(key);
			} catch (RuntimeException e) {
			}
    	}
        return null;
    }


    /**
     * Get an optional double associated with a key,
     * or Null if there is no such key or if its value is not a long.
     *
     * @param key   A string which is the key.
     * @return      A double which is the value.
     */
    public Double getDouble(String key) {
    	if (this.containsKey(key)) {
    		try {
				return this.reqDouble(key);
			} catch (RuntimeException e) {
			}
    	}
        return null;
    }


    /**
     * Get an optional integer value associated with a key,
     * or null if there is no such key or if the value is not an integer.
     *
     * @param key   A key string.
     * @return      An integer which is the value.
     */
    public Integer getInteger(String key) {
    	if (this.containsKey(key)) {
    		try {
				return this.reqInteger(key);
			} catch (RuntimeException e) {
			}
    	}
        return null;
    }


    /**
     * Get an optional Set associated with a key.
     * It returns null if there is no such key, or if its value is not a
     * Set.
     *
     * @param key   A key string.
     * @return      A Set which is the value.
     */
	public Set<?> getSet(String key) {
    	if (this.containsKey(key)) {
    		try {
				return this.reqSet(key);
			} catch (RuntimeException e) {
			}
    	}
        return null;
    }


    /**
     * Get an optional long value associated with a key,
     * or null if there is no such key or if the value is not a long.
     *
     * @param key   A key string.
     * @return      A long which is the value.
     */
    public Long getLong(String key) {
    	if (this.containsKey(key)) {
    		try {
				return this.reqLong(key);
			} catch (RuntimeException e) {
			}
    	}
        return null;
    }


    /**
     * Get an optional string associated with a key.
     * It returns null if there is no such key. If the value is not
     * a string.
     *
     * @param key   A key string.
     * @return      A string which is the value.
     */
    public String getString(String key) {
    	if (this.containsKey(key)) {
    		try {
				return this.reqString(key);
			} catch (RuntimeException e) {
			}
    	}
        return null;
    }



    /**
     * Put a key/value pair in the QgMap, but only if the key and the
     * value are both non-null, and only if there is not already a member
     * with that name.
     * @param key
     * @param value
     * @return his.
     * @throws RuntimeException if the key is a duplicate
     */
    public void putOnce(String key, Object value) throws RuntimeException {
        if (key != null && value != null) {
            if (get(key) != null) {
                throw new RuntimeException("Duplicate key \"" + key + "\"");
            }
            put(key, value);
        }
    }

}
