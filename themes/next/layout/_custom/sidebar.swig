{% if site.tags.length > 0 %}
    <hr/>
    
    <div class="tag-cloud">  
        <div class="tag-cloud-title"> 
            {% set visibleTags = 0 %}
            {% for tag in site.tags %}
            {% if tag.length %}
                {% set visibleTags += 1 %}
            {% endif %}
            {% endfor %}
            <a href="{{ url_for(config.tag_dir) + '/' }}"> {{visibleTags}} Tags </a>
        </div>
        <div class="tag-cloud-tags">
            {{ tagcloud({min_font: 12, max_font: 18, amount: 10, color: true, start_color: '#ccc', end_color: '#111'}) }}
        </div>
    </div>
{% endif %}