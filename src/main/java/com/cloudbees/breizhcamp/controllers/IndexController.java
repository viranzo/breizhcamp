package com.cloudbees.breizhcamp.controllers;

import com.cloudbees.breizhcamp.domain.Day;
import com.cloudbees.breizhcamp.domain.Event;
import com.cloudbees.breizhcamp.domain.Talk;
import com.cloudbees.breizhcamp.domain.TimeSlot;
import com.cloudbees.breizhcamp.services.ScheduleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Handle request for index page
 *
 * @author Alexandre THOMAZO &lt;alex@thomazo.info&gt;
 */
@Controller
public class IndexController {

    @Autowired
    private ScheduleService scheduleService;

    @RequestMapping("/index.htm")
    public String index(ModelMap model, @RequestParam(defaultValue = "") String jour, @RequestParam(defaultValue = "false") boolean hide){
        model.put("hide", hide);
        Data data = null;

        data = scheduleService.getData(jour);

        model.put("dates", data.getDatesOrdonnees());
        model.put("talks", data.getNewTalks());
        model.put("bornes", data.getBornes());
        model.put("sansRoom", "sansRoom");
        return "index";
    }

    @RequestMapping("/contact.htm")
    public String contact(ModelMap model, @RequestParam(defaultValue = "false") boolean hide) {
        model.put("hide", hide);
        return "contact";
    }

    @RequestMapping("/bookmarks.htm")
    public String bookmarks(ModelMap model, @RequestParam(defaultValue = "false") boolean hide) {
        model.put("hide", hide);
        return "bookmarks";
    }

    @RequestMapping(value = "/event.json", method = RequestMethod.GET, produces = "application/json")
    @ResponseBody
    public Event event() {
        Event event = new Event();
        event.setName("BreizhCamp - 14-15 Juin 2012");
        event.getSpeakers().addAll(scheduleService.getSpeakers());
        event.getRooms().addAll(scheduleService.getRooms());

        SimpleDateFormat sdfHeure = new SimpleDateFormat("HH:mm");
        SimpleDateFormat sdfDate = new SimpleDateFormat("dd/MM/yyyy");

        Map<String, ArrayList<TimeSlot>> creneaux = new HashMap<String, ArrayList<TimeSlot>>();
        Map<String, TimeSlot> slots = new HashMap<String, TimeSlot>();
        for (Talk talk : scheduleService.getTalks()) {
            String date = sdfDate.format(talk.getStart());
            if (!creneaux.containsKey(date)) {
                creneaux.put(date, new ArrayList<TimeSlot>());
            }
            TimeSlot slot = new TimeSlot();

            if (talk.getStart() != null) {
                Calendar cal = Calendar.getInstance();
                cal.setTime(talk.getStart());
                cal.add(Calendar.MINUTE, talk.getDuree());
                slot.name = sdfHeure.format(talk.getStart()) + " - " + sdfHeure.format(cal.getTime());
            } else {
                slot.name = "";
            }
            slot.date = date;

            if (!slots.containsKey(date + slot.name)) {
                slots.put(date + slot.name, slot);
                creneaux.get(date).add(slot);
            }
            slots.get(date + slot.name).sessions.add(talk);
        }

        Set<Day> days = new HashSet<Day>();

        for (Map.Entry<String, ArrayList<TimeSlot>> entry : creneaux.entrySet()) {
            Day day = new Day();
            day.jour = entry.getKey();

            Collections.sort(entry.getValue());
            day.getTimeSlots().addAll(entry.getValue());

            days.add(day);
        }

        event.getDays().addAll(days);
        return event;
    }

    @RequestMapping("/gettwitter.htm")
    @ResponseBody
    public String getTwitter(@RequestParam String twitter) throws IOException {
        URL url = new URL("http://api.twitter.com/1/users/profile_image?screen_name="
                + twitter + "&size=bigger");
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setInstanceFollowRedirects(false);
        String result = conn.getHeaderField("Location");
        conn.disconnect();

        return result;

    }

    @RequestMapping("/error/notie.htm")
    public String index() {
        return "error/notie";
    }
}
