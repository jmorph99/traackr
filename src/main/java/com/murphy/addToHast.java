package com.murphy;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */



import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;



/**
 *
 * @author murphy
 */
public class addToHast {
    public static void add(HashMap<String,Integer> hash, String key)
    {
        if(hash.containsKey(key))
            hash.put(key, hash.get(key)+1);
        else
            hash.put(key, 1);
    }
    public static void addSet(HashSet<String> hash, String key)
    {
        if(!hash.contains(key))
            hash.add(key);
    }
    public static LinkedHashMap<String, Integer> sortHashMapByValues(HashMap<String, Integer> map) 
    {
        Object[] a = map.entrySet().toArray();
        Arrays.sort(a, new Comparator() 
        {
            public int compare(Object o1, Object o2) 
            {
                 return ((Map.Entry<String, Integer>) o2).getValue()
                            .compareTo(((Map.Entry<String, Integer>) o1).getValue());
            }
        });
        LinkedHashMap<String, Integer> newmap = new LinkedHashMap();
        for (Object e : a) {
    newmap.put(((Map.Entry<String, Integer>) e).getKey() ,((Map.Entry<String, Integer>) e).getValue());
        }
        return newmap;
    }
}

