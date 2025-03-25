FROM grafana/grafana

COPY grafana.ini /etc/grafana/grafana/
COPY datasources.yml /etc/grafana/provisioning/datasources/
COPY dashboards.yml dashboards /etc/grafana/provisioning/dashboards/

EXPOSE 3000