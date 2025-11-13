#!/bin/sh

if [ -n "$DESTDIR" ] ; then
    case $DESTDIR in
        /*) # ok
            ;;
        *)
            /bin/echo "DESTDIR argument must be absolute... "
            /bin/echo "otherwise python's distutils will bork things."
            exit 1
    esac
fi

echo_and_run() { echo "+ $@" ; "$@" ; }

echo_and_run cd "/home/cyz/lidar_camera_slam_cyz/src/rpg_vikit/vikit_py"

# ensure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/home/cyz/lidar_camera_slam_cyz/install/lib/python3/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/home/cyz/lidar_camera_slam_cyz/install/lib/python3/dist-packages:/home/cyz/lidar_camera_slam_cyz/build/lib/python3/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/home/cyz/lidar_camera_slam_cyz/build" \
    "/usr/bin/python3" \
    "/home/cyz/lidar_camera_slam_cyz/src/rpg_vikit/vikit_py/setup.py" \
     \
    build --build-base "/home/cyz/lidar_camera_slam_cyz/build/rpg_vikit/vikit_py" \
    install \
    --root="${DESTDIR-/}" \
    --install-layout=deb --prefix="/home/cyz/lidar_camera_slam_cyz/install" --install-scripts="/home/cyz/lidar_camera_slam_cyz/install/bin"
