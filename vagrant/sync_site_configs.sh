#!/usr/bin/env bash

rsync -a -v /vagrant/vagrant/sites/*.conf /etc/apache2/sites-available
