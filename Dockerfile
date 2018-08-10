FROM philipnrmn/prometheus-on-dcos:proxy

# Install rq and the configuration script
COPY bin/configure.sh /bin/configure
COPY etc/prometheus.yml /etc/prometheus/prometheus.yml
ENTRYPOINT "/bin/start"
