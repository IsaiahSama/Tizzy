package com.example.tizzy_watch

import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.widget.RemoteViews

import es.antonborri.home_widget.HomeWidgetPlugin
/**
 * Implementation of App Widget functionality.
 */
class CountdownWidget : AppWidgetProvider() {
    override fun onUpdate(context: Context, appWidgetManager: AppWidgetManager, appWidgetIds: IntArray) {
        // There may be multiple widgets active, so update all of them
        for (appWidgetId in appWidgetIds) {
            // Get reference to SharedPreferences.
            val widgetData = HomeWidgetPlugin.getData(context)
            val views = RemoteViews(context.packageName, R.layout.countdown_widget).apply {

                val title = widgetData.getString("countdown_title", null)
                setTextViewText(R.id.countdown_title, title ?: "No title set")

                val duration = widgetData.getString("countdown_duration", null)
                setTextViewText(R.id.countdown_duration, duration ?: "No duration set")
            }

            appWidgetManager.updateAppWidget(appWidgetId, views)
        }
    }

    override fun onEnabled(context: Context) {
        // Enter relevant functionality for when the first widget is created
    }

    override fun onDisabled(context: Context) {
        // Enter relevant functionality for when the last widget is disabled
    }
}