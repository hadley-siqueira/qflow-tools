# change the install path
INSTALL_DIR=/home/hadley/Aplicativos/qflow-tools2

# do not change
QFLOW_TOOLS_DIR=$INSTALL_DIR/qflow-tools
QFLOW_DIR=$QFLOW_TOOLS_DIR/qflow
MAGIC_DIR=$QFLOW_TOOLS_DIR/magic
NETGEN_DIR=$QFLOW_TOOLS_DIR/netgen
YOSYS_DIR=$QFLOW_TOOLS_DIR/yosys
QROUTER_DIR=$QFLOW_TOOLS_DIR/qrouter
GRAYWOLF_DIR=$QFLOW_TOOLS_DIR/graywolf
IRSIM_DIR=$QFLOW_TOOLS_DIR/irsim

YOSYS_CMD="PREFIX := $YOSYS_DIR"
QFLOW_CONFIG="--with-yosys=$YOSYS_DIR/bin --with-graywolf=$GRAYWOLF_DIR/bin --with-qrouter=$QROUTER_DIR/bin --with-magic=$MAGIC_DIR/bin --with-netgen=$NETGEN_DIR/bin"

mkdir $QFLOW_TOOLS_DIR
cd $QFLOW_TOOLS_DIR

## download qflow
wget http://opencircuitdesign.com/qflow/archive/qflow-1.3.13.tgz
#
## download yosys
wget https://github.com/cliffordwolf/yosys/archive/yosys-0.8.tar.gz
#
## download graywolf
git clone https://github.com/rubund/graywolf.git
#
## download qrouter
wget http://opencircuitdesign.com/qrouter/archive/qrouter-1.4.49.tgz
#
## download magic
wget http://opencircuitdesign.com/magic/archive/magic-8.2.102.tgz
#
## download netgen
wget http://opencircuitdesign.com/netgen/archive/netgen-1.5.118.tgz
#

## download irsim
wget http://opencircuitdesign.com/irsim/archive/irsim-9.7.101.tgz
## extracting files...
tar xf yosys-0.8.tar.gz
tar xf qrouter-1.4.49.tgz
tar xf qflow-1.3.13.tgz
tar xf netgen-1.5.118.tgz
tar xf magic-8.2.102.tgz
tar xf irsim-9.7.101.tgz

## create folders for the binaries
mkdir qflow netgen magic yosys qrouter
#
## install magic
## dependencies
sudo apt install m4 tcsh libx11-dev tcl-dev tk-dev libglu1-mesa-dev
#
cd magic-8.2.102
./configure --prefix="$MAGIC_DIR"
make
make install
cd ..
#
## install graywolf
## dependencies
sudo apt install libgsl-dev
mv graywolf graywolf-git
mkdir graywolf
cd graywolf-git
mkdir build
cd build
cmake -DCMAKE_INSTALL_PREFIX="$GRAYWOLF_DIR" ..
make  
make install
cd ../..
#
## install qrouter
mkdir qrouter
cd qrouter-1.4.49
./configure --prefix="$QROUTER_DIR"
make
make install
cd ..
#
## install netgen
mkdir netgen
cd netgen-1.5.118
./configure --prefix="$NETGEN_DIR"
make
make install
cd ..

# install yosys
# dependencies
sudo apt-get install libreadline-dev bison flex build-essential clang bison flex libreadline-dev gawk tcl-dev libffi-dev git graphviz xdot pkg-config python3
cd yosys-yosys-0.8
make config-clang
echo $YOSYS_CMD >> Makefile.conf
make
make install
cp yosys yosys-config yosys-abc yosys-filterlib yosys-smtbmc /home/hadley/Aplicativos/qflow-tools/yosys/bin/
cd ..

# install qflow
cd qflow-1.3.13
./configure $QFLOW_CONFIG --prefix=$QFLOW_DIR
make
make install

# install irsim
cd irsim-9.7.101
./configure --prefix=$IRSIM_DIR
make
make install
