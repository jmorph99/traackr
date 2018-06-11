/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;



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
    public static LinkedHashMap<String, Integer> sortHashMapByValues(
        HashMap<String, Integer> passedMap) {
    List<Integer> mapKeys = new ArrayList<>(passedMap.values());
    List<String> mapValues = new ArrayList<>(passedMap.keySet());
    Collections.sort(mapValues);
    Collections.sort(mapKeys);

    LinkedHashMap<String, Integer> sortedMap =
        new LinkedHashMap<>();

    Iterator<String> valueIt = mapValues.iterator();
    while (valueIt.hasNext()) {
        String val = valueIt.next();
        Iterator<Integer> keyIt = mapKeys.iterator();

        while (keyIt.hasNext()) {
            Integer key = keyIt.next();
            Integer comp1 = passedMap.get(key);
            String comp2 = val;

            if (comp1.equals(comp2)) {
                keyIt.remove();
                sortedMap.put(val,key);
                break;
            }
        }
    }
    return sortedMap;
}
}
