export SETUP_PATH=/opt/maczero

sudo mkdir -p /opt/
sudo chown $USER /opt/
git clone . $SETUP_PATH
sudo gem update --system
sudo gem install bundler
cd $SETUP_PATH
bundle install
