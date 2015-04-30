export default [
  {
    id: 1,
    name: 'Weathermatic HQ',
    address1: '3301 W. Kingsley Rd',
    address2: '',
    city: 'Garland',
    state: 'TX',
    postal_code: '75043',
    latitude: '32.8493511',
    longitude: '-96.5890166',
    controllers: [
      {
        id: 1,
        name: 'Main Controller',
        run_status: 1,
        mode: 1,
        sw_status: 1,
        sensor_mode: 1,
        programs: [
          {
            id: 1,
            identifier: 'A',
            program_type: 1,
          },
          {
            id: 2,
            identifier: 'B',
            program_type: 1,
          },
          {
            id: 3,
            identifier: 'C',
            program_type: 1,
          },
          {
            id: 4,
            identifier: 'D',
            program_type: 1,
          }
        ],
        zones: [
          {
            id: 1,
            number: 1,
            description: 'Flower Beds'
          },
          {
            id: 2,
            number: 2,
            description: 'Shrubs & Bushes'
          },
          {
            id: 3,
            number: 3,
            description: 'Trees'
          },
          {
            id: 4,
            number: 4,
            description: 'Font Lawn'
          },
          {
            id: 5,
            number: 5,
            description: 'Back Lawn'
          }
        ],
        faults: [
          {
            id: 1,
            description: "Zone 6 - Sprinkler 'Off' in Auto-Adjust",
            date: '2015-04-08T09:47:19Z'
          },
          {
            id: 2,
            description: 'Aircard Communications Error',
            date: '2015-04-08T09:47:19Z'
          }
        ]
      }
    ]
  },
  {
    id: 2,
    name: 'Good 2 Go Tacos',
    address1: '1146 Peavy Rd',
    address2: '',
    city: 'Dallas',
    state: 'TX',
    postal_code: '75218',
    latitude: '32.840811',
    longitude: '-96.696939',
    controllers: [
      {
        id: 2,
        name: 'Main Controller',
        run_status: 0,
        mode: 1,
        sw_status: 0,
        sensor_mode: 0,
        programs: [
          {
            id: 5,
            identifier: 'A',
            program_type: 1,
          },
          {
            id: 6,
            identifier: 'B',
            program_type: 1,
          },
          {
            id: 7,
            identifier: 'C',
            program_type: 1,
          },
          {
            id: 8,
            identifier: 'D',
            program_type: 1,
          }
        ],
        zones: [
          {
            id: 6,
            number: 1,
            description: 'Front Yard'
          },
          {
            id: 7,
            number: 2,
            description: 'Back Yard'
          }
        ],
        faults: [
          {
            id: 3,
            description: 'Aircard Communications Error',
            date: '2015-04-08T09:47:19Z'
          }
        ]
      }
    ]
  },
  {
    id: 3,
    name: 'Active Network Office',
    address1: '715 Harwood Dr',
    address2: 'Suite 25000',
    city: 'Dallas',
    state: 'TX',
    postal_code: '75201',
    latitude: '32.786023',
    longitude: '-96.798153',
    controllers: [
      {
        id: 3,
        name: 'North Flower Beds',
        run_status: 0,
        mode: 0,
        sw_status: 2,
        sensor_mode: 0,
        programs: [
          {
            id: 9,
            identifier: 'A',
            program_type: 1,
          },
          {
            id: 10,
            identifier: 'B',
            program_type: 1,
          },
          {
            id: 11,
            identifier: 'C',
            program_type: 1,
          },
          {
            id: 12,
            identifier: 'D',
            program_type: 1,
          }
        ],
        zones: [
          {
            id: 8,
            number: 1,
            description: 'Front Yard'
          },
          {
            id: 9,
            number: 2,
            description: 'Back Yard'
          }
        ],
        faults: []
      },
      {
        id: 4,
        name: 'South Flower Beds',
        run_status: 1,
        mode: 1,
        sw_status: 1,
        sensor_mode: 0,
        programs: [
          {
            id: 13,
            identifier: 'A',
            program_type: 1,
          },
          {
            id: 14,
            identifier: 'B',
            program_type: 1,
          },
          {
            id: 15,
            identifier: 'C',
            program_type: 1,
          },
          {
            id: 16,
            identifier: 'D',
            program_type: 1,
          }
        ],
        zones: [
          {
            id: 10,
            number: 1,
            description: 'Front Yard'
          },
          {
            id: 11,
            number: 2,
            description: 'Back Yard'
          }
        ],
        faults: []
      }
    ]
  }
];
