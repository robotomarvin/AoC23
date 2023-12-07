import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

class Main {
    static class RangeSet {
        private final ArrayList<long[]> ranges;
        public RangeSet() {
            ranges = new ArrayList<>();
        }

        public void addRange(long left, long right) {
            ranges.add(new long[]{left, right});

        }

        public List<long[]> getAll() {
            ranges.sort((o1, o2) -> Long.signum(o1[0] - o2[0]));
            ArrayList<long[]> out = new ArrayList<>();
            out.add(ranges.get(0));
            int lastIndex = 0;

            for (int i = 1; i < ranges.size(); i++) {
                if (out.get(lastIndex)[1] < ranges.get(i)[0] - 1) {
                    out.add(ranges.get(i));
                    lastIndex++;
                    continue;
                }
                out.get(lastIndex)[1] = Long.max(ranges.get(i)[1], out.get(lastIndex)[1]);
            }
            return out;
        }
    }

    static class Map {
        private final List<long[]> maps = new ArrayList<>();
        public void add(long destination, long source, long length)
        {
            maps.add(new long[]{source, source + length - 1, destination - source});
        }

        public List<long[]> get() {
            maps.sort((o1, o2) -> Long.signum(o1[0] - o2[0]));
            return maps;
        }
    }

    public static void main(String[] args) throws IOException {
        long start_time = System.currentTimeMillis();
        BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
        String line = reader.readLine();
        String[] inputSeeds = line.split(": ")[1].split(" ");
        RangeSet currentRange = new RangeSet();
        for (int i = 0; i < inputSeeds.length; i+= 2) {
            long start = Long.parseLong(inputSeeds[i]);
            long end = Long.parseLong(inputSeeds[i+1]) + start;
            currentRange.addRange(start, end);
        }
        reader.readLine();
        ArrayList<Map> maps = new ArrayList<Map>();
        Map currentMap = null;
        while ((line = reader.readLine()) != null) {
            if (line.contains(":")) {
                currentMap = new Map();
                maps.add(currentMap);
                continue;
            }
            if (line.isBlank()) {
                continue;
            }

            long[] data = Arrays.stream(line.split(" ")).mapToLong(Long::parseLong).toArray();
            assert currentMap != null;
            currentMap.add(data[0], data[1], data[2]);
        }
        RangeSet newRange = new RangeSet();
        for (Map m: maps) {
            List<long[]> ranges = currentRange.getAll();
            List<long[]> transforms = m.get();
            int i = 0;
            long[] range = ranges.get(i);
            int j = 0;
            long[] transform = transforms.get(j);
            while (i < ranges.size()) {
                while (j < transforms.size() && transform[1] < range[0]) {
                    j++;
                    transform = j >= transforms.size() ?
                            new long[]{0, Long.MAX_VALUE, 0} :
                            transforms.get(j);
                }
                if (range[0] < transform[0]) {
                    newRange.addRange(range[0], transform[0] - 1);
                    range[0] = transform[0];
                }
                if (range[0] > range[1]) {
                    i++;
                    if (i >= ranges.size()) {
                        break;
                    }
                    range = ranges.get(i);
                    continue;
                }
                long min = Long.min(range[1], transform[1]);
                newRange.addRange(range[0] + transform[2], min + transform[2]);
                if (min == range[1]) {
                    i++;
                    if (i >= ranges.size()) {
                        break;
                    }
                    range = ranges.get(i);
                } else {
                    range[0] = min+1;
                }
                if(min == transform[1] && j < transforms.size()) {
                    j++;
                    transform = j >= transforms.size() ?
                            new long[]{0, Long.MAX_VALUE, 0} :
                            transforms.get(j);
                }
            }
            currentRange = newRange;
            newRange = new RangeSet();
        }
        System.out.println(currentRange.getAll().get(0)[0]);
        long end_time = System.currentTimeMillis();
        System.out.printf("Time (ms): %d\n", end_time-start_time);
    }
}